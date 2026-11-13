const nodemailer = require('nodemailer');

module.exports = async function handler(req, res) {
  // CORS Headers
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  try {
    const { name, email, platform, issue, message, clientTime, timeZone } = req.body || {};

    if (!name || !email || !message) {
      return res.status(400).json({ error: 'Name, email, and message are required.' });
    }

    const ticketId = 'WX-' + Math.floor(100000 + Math.random() * 900000);
    const adminEmail = 'contact.widgetx@gmail.com';

    // 24-Hour Time Format according to User's state/region timezone (or IST)
    let formattedTimestamp = clientTime;
    if (!formattedTimestamp) {
      try {
        const targetTz = timeZone || 'Asia/Kolkata';
        formattedTimestamp = new Intl.DateTimeFormat('en-GB', {
          timeZone: targetTz,
          hour12: false, // Strict 24-hour format
          year: 'numeric',
          month: 'short',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          timeZoneName: 'short',
        }).format(new Date()) + ' (24hr)';
      } catch (_) {
        formattedTimestamp = new Date().toISOString().replace('T', ' ').substring(0, 19) + ' UTC (24hr)';
      }
    }

    // Check for SMTP / Gmail app password in environment
    const smtpUser = process.env.SMTP_USER || process.env.GMAIL_USER || adminEmail;
    const smtpPass = process.env.SMTP_PASS || process.env.GMAIL_APP_PASSWORD;

    let deliveredToAdmin = false;
    let deliveredToUser = false;
    let deliveryNote = '';

    if (smtpPass) {
      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: smtpUser,
          pass: smtpPass,
        },
      });

      // 1. Send notification email to admin (contact.widgetx@gmail.com)
      await transporter.sendMail({
        from: `"WidgetX Support System" <${smtpUser}>`,
        to: adminEmail,
        replyTo: email,
        subject: `[Ticket #${ticketId}] New Support Inquiry: ${issue || 'General'} (${platform || 'Web'})`,
        text: `New support inquiry received:\n\nTicket: #${ticketId}\nSender: ${name} <${email}>\nPlatform: ${platform || 'General'}\nIssue Scope: ${issue || 'General'}\nReceived At (24h): ${formattedTimestamp}\n\nMessage:\n${message}`,
        html: `
          <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #0A192F; color: #FFFFFF; padding: 28px; border-radius: 12px; max-width: 650px;">
            <div style="border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 16px; margin-bottom: 20px;">
              <h2 style="color: #2DE2B6; margin: 0 0 6px 0; font-size: 20px;">New WidgetX Support Request</h2>
              <span style="font-family: monospace; color: #64FFDA; font-size: 13px;">Ticket Reference: #${ticketId}</span>
            </div>
            <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px; color: #CCD6F6; font-size: 14px;">
              <tr><td style="padding: 6px 0; color: #8892B0; width: 140px;">Sender:</td><td style="font-weight: 600;">${name} &lt;${email}&gt;</td></tr>
              <tr><td style="padding: 6px 0; color: #8892B0;">Platform:</td><td>${platform || 'N/A'}</td></tr>
              <tr><td style="padding: 6px 0; color: #8892B0;">Issue Scope:</td><td>${issue || 'N/A'}</td></tr>
              <tr><td style="padding: 6px 0; color: #8892B0;">Received At (24h):</td><td style="font-family: monospace; color: #2DE2B6; font-weight: 600;">${formattedTimestamp}</td></tr>
            </table>
            <div style="background-color: #101E36; border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; padding: 18px; margin-bottom: 20px;">
              <div style="font-size: 12px; font-weight: 600; color: #2DE2B6; margin-bottom: 8px; letter-spacing: 1px;">MESSAGE CONTENT</div>
              <div style="white-space: pre-wrap; color: #F1F5F9; line-height: 1.6; font-size: 14px;">${message}</div>
            </div>
            <p style="margin: 0; font-size: 12px; color: #8892B0;">
              You can reply directly to this email to contact the user at <strong>${email}</strong>.
            </p>
          </div>
        `,
      });
      deliveredToAdmin = true;

      // 2. Send delivery confirmation auto-reply to the user (samne wale ko)
      await transporter.sendMail({
        from: `"WidgetX Support" <${smtpUser}>`,
        to: email,
        replyTo: adminEmail,
        subject: `[WidgetX] Inquiry Received & Dispatched (#${ticketId})`,
        text: `Hello ${name},\n\nThank you for contacting WidgetX Support. This confirms that your request regarding "${issue || 'your inquiry'}" for ${platform || 'WidgetX Apps'} has been successfully delivered and logged into our queue.\n\nTicket Reference: #${ticketId}\nEstimated Response Time: Within 24 business hours.\n\nSummary of your request:\n"${message}"\n\nIf you have additional logs or details to share, you can reply directly to this email or reach us at contact.widgetx@gmail.com.\n\nBest regards,\nWidgetX Compliance & Engineering Team\nhttps://github.com`,
        html: `
          <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #0A192F; color: #FFFFFF; padding: 28px; border-radius: 12px; max-width: 600px;">
            <div style="border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 16px; margin-bottom: 20px;">
              <h2 style="color: #2DE2B6; margin: 0 0 6px 0; font-size: 20px;">Inquiry Received &amp; Logged</h2>
              <span style="font-family: monospace; color: #64FFDA; font-size: 13px;">Ticket Reference: #${ticketId}</span>
            </div>
            <p style="color: #CCD6F6; font-size: 15px; margin-top: 0;">Hello <strong>${name}</strong>,</p>
            <p style="color: #8892B0; line-height: 1.6; font-size: 14px;">
              Thank you for contacting WidgetX. We have received your inquiry regarding <strong style="color: #F1F5F9;">${issue || 'your request'}</strong> for <strong style="color: #F1F5F9;">${platform || 'WidgetX'}</strong>.
            </p>
            <div style="background-color: #101E36; border-left: 4px solid #2DE2B6; border-radius: 4px; padding: 14px 18px; margin: 20px 0;">
              <div style="font-weight: 600; color: #2DE2B6; font-size: 13.5px;">✓ Status: In Review Queue</div>
              <div style="color: #8892B0; font-size: 13px; margin-top: 4px;">
                Received At (24h): <strong style="color: #64FFDA; font-family: monospace;">${formattedTimestamp}</strong>
              </div>
              <div style="color: #8892B0; font-size: 13px; margin-top: 4px;">
                Our compliance and engineering team typically processes all inquiries within <strong>24 business hours</strong>.
              </div>
            </div>
            <div style="background-color: rgba(255,255,255,0.04); border-radius: 8px; padding: 14px; margin-bottom: 20px;">
              <div style="font-size: 11px; font-family: monospace; color: #64FFDA; margin-bottom: 6px;">YOUR SUBMISSION:</div>
              <div style="color: #CCD6F6; font-size: 13.5px; font-style: italic; white-space: pre-wrap;">"${message.length > 200 ? message.slice(0, 200) + '...' : message}"</div>
            </div>
            <p style="color: #8892B0; font-size: 13px; line-height: 1.5;">
              If you have any attachments or additional context to append, reply directly to this email or write to <a href="mailto:contact.widgetx@gmail.com" style="color: #2DE2B6; text-decoration: none;">contact.widgetx@gmail.com</a> quoting ticket <strong>#${ticketId}</strong>.
            </p>
            <hr style="border: none; border-top: 1px solid rgba(255,255,255,0.1); margin: 24px 0 16px 0;" />
            <div style="font-size: 12px; color: #64748B;">
              WidgetX Systems • Software Publisher &bull;
              <a href="https://github.com" style="color: #2DE2B6; text-decoration: none;">GitHub</a> &bull;
              <a href="https://linkedin.com" style="color: #2DE2B6; text-decoration: none;">LinkedIn</a>
            </div>
          </div>
        `,
      });
      deliveredToUser = true;
      deliveryNote = 'Emails dispatched to both contact.widgetx@gmail.com and the sender.';
    } else {
      deliveryNote = 'Request logged. To dispatch live emails from contact.widgetx@gmail.com, add GMAIL_APP_PASSWORD in your Vercel project environment variables.';
      console.log(`[Ticket #${ticketId}] Support inquiry from ${name} <${email}>:`, { platform, issue, message });
    }

    return res.status(200).json({
      success: true,
      ticketId,
      timestamp: formattedTimestamp,
      adminEmail,
      userEmail: email,
      deliveredToAdmin,
      deliveredToUser,
      deliveryNote,
      message: 'Request processed successfully.',
    });
  } catch (err) {
    console.error('API Contact Error:', err);
    return res.status(500).json({
      success: false,
      error: 'Internal server error processing contact request: ' + err.message,
    });
  }
};
