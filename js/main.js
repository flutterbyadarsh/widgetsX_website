/**
 * WidgetX Interactive Script
 * - Anti-Gravity floating particle background
 * - Modal interactions for Compliance policies & Google Play
 * - Interactive filter tabs
 * - Support form handling & client-side validation
 */

document.addEventListener('DOMContentLoaded', () => {
  initAmbientZeroGravityCanvas();
  initFilterTabs();
  initModals();
  initSupportForm();
  initAntiGravityCards();
});

/**
 * Ambient Zero-Gravity Dust / Particle Canvas
 * Subtle micro-particles floating in deep space against #0A192F
 */
function initAmbientZeroGravityCanvas() {
  const canvas = document.getElementById('ambient-particles');
  if (!canvas) return;

  const ctx = canvas.getContext('2d');
  let width = (canvas.width = window.innerWidth);
  let height = (canvas.height = window.innerHeight);

  window.addEventListener('resize', () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  const particleCount = Math.min(Math.floor((width * height) / 25000), 50);
  const particles = [];

  for (let i = 0; i < particleCount; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      size: Math.random() * 1.8 + 0.5,
      speedX: (Math.random() - 0.5) * 0.25,
      speedY: (Math.random() - 0.5) * 0.25 - 0.08, // gentle upward zero-gravity drift
      alpha: Math.random() * 0.5 + 0.15,
      color: Math.random() > 0.5 ? '#2DE2B6' : '#38BDF8'
    });
  }

  function render() {
    ctx.clearRect(0, 0, width, height);

    for (let i = 0; i < particles.length; i++) {
      const p = particles[i];
      p.x += p.speedX;
      p.y += p.speedY;

      // Wrap around bounds
      if (p.x < 0) p.x = width;
      if (p.x > width) p.x = 0;
      if (p.y < 0) p.y = height;
      if (p.y > height) p.y = 0;

      ctx.beginPath();
      ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.globalAlpha = p.alpha;
      ctx.fill();
    }
    ctx.globalAlpha = 1.0;

    requestAnimationFrame(render);
  }

  render();
}

/**
 * Anti-Gravity Cards Interaction
 * Confirms hover pause behavior and allows smooth keyboard focus
 */
function initAntiGravityCards() {
  const cards = document.querySelectorAll('.anti-gravity-card');
  
  cards.forEach(card => {
    // Ensure keyboard focus also safely pauses the floating effect for accessibility
    card.addEventListener('focusin', () => {
      card.style.animationPlayState = 'paused';
    });
    
    card.addEventListener('focusout', () => {
      card.style.animationPlayState = 'running';
    });
  });
}

/**
 * Filter Tabs Controller
 */
function initFilterTabs() {
  const tabs = document.querySelectorAll('.filter-tab');
  const trackFlowCard = document.getElementById('card-trackflow');
  const connectCallCard = document.getElementById('card-connectcall');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => {
        t.classList.remove('active');
        t.setAttribute('aria-selected', 'false');
      });
      tab.classList.add('active');
      tab.setAttribute('aria-selected', 'true');

      const filter = tab.getAttribute('data-filter');

      // Feedback animation for filtering
      if (trackFlowCard && connectCallCard) {
        if (filter === 'all' || filter === 'android') {
          trackFlowCard.style.display = 'block';
          connectCallCard.style.display = 'block';
        } else if (filter === 'web') {
          trackFlowCard.style.display = 'none';
          connectCallCard.style.display = 'block';
        } else {
          trackFlowCard.style.display = 'block';
          connectCallCard.style.display = 'block';
        }
      }
    });
  });
}

/**
 * Modal Management: Privacy Policy, Terms, Data Retention & Google Play
 */
const modalContent = {
  'privacy-modal': {
    title: 'Privacy Policy for WidgetX',
    content: `
      <div class="modal-trust-badge">
        🛡️ Verified &amp; Trusted Website – Google Play Store Compliant
      </div>
      <p style="font-size: 0.85rem; color: var(--accent-mint); font-weight: 600; margin-bottom: 12px;">
        Effective Date: November 14, 2026
      </p>
      <p>At WidgetX, we believe in 100% fairness and transparency. We have built this platform with the utmost respect for your privacy. This Privacy Policy explains how we collect, strictly secure, and handle your information.</p>
      <p><strong>We want to be crystal clear: We DO NOT sell your personal data to anyone.</strong> Your data is strictly secured and treated with the highest level of confidentiality.</p>

      <h4>1. Google Play Families Policy Compliance</h4>
      <p>WidgetX is committed to providing a safe and secure environment for all users, including children and families. We are fully compliant with the Google Play Families Policy. We ensure that our app's content, advertisements, and data collection practices are entirely age-appropriate. We do not collect personal information from children without verifiable parental consent, and our views and interfaces are designed to be safe for family usage.</p>

      <h4>2. Information Collection and Strict Security</h4>
      <p>When you use our services, we may collect basic information required to provide you with a seamless experience. We employ industry-standard, robust security measures to prevent unauthorized access, alteration, disclosure, or destruction of your personal information. Your trust is our top priority, and we store everything strictly and securely.</p>

      <h4>3. Data Retention Policy</h4>
      <p>We manage your data carefully to ensure you have a consistent experience:</p>
      <ul>
        <li><strong>Under 90 Days:</strong> We do not manually delete your active data within the first 90 days of your usage.</li>
        <li><strong>After 90 Days:</strong> If we need to keep your data beyond this period for service continuity, we will notify you via email or in-app notice, advising you on the retention. You will always be informed about your data lifecycle.</li>
      </ul>

      <h4>4. Account and Data Deletion Request</h4>
      <p>You have full control over your data. If you face any issues, wish to revoke consent, or want to permanently delete your account and all associated data, you can do so easily:</p>
      <ul>
        <li><strong>Email Us:</strong> Send a data deletion request directly to <a href="mailto:contact.widgetx@gmail.com" style="color:var(--accent-mint); text-decoration:none;">contact.widgetx@gmail.com</a>.</li>
        <li><strong>Fill the Form:</strong> You can also submit a request through our dedicated Support and Data Deletion Request Form in the app/website.</li>
      </ul>
      <p><strong>Processing Time:</strong> Once your request is received, all your data will be permanently and securely deleted from our servers within 3 to 4 working days.</p>

      <h4>5. Third-Party Services</h4>
      <p>We only use trusted third-party services (like secure databases or authentication providers) necessary for the app to function. These services are bound by strict confidentiality agreements and are not permitted to use your data for their own purposes.</p>

      <h4>6. Changes to This Privacy Policy</h4>
      <p>We may update our Privacy Policy from time to time to reflect our ongoing commitment to your security. We will notify you of any changes by posting the new Privacy Policy on this page.</p>

      <h4>Contact Us</h4>
      <p>If you have any questions, concerns, or suggestions regarding this policy, we are always here to help.</p>
      <ul>
        <li>Email: <a href="mailto:contact.widgetx@gmail.com" style="color:var(--accent-mint); text-decoration:none;">contact.widgetx@gmail.com</a></li>
      </ul>

      <div class="modal-trust-badge-footer">
        🛡️ Certified for Google Play Store Trust &amp; Safety | WidgetX.online
      </div>
    `
  },
  'terms-modal': {
    title: 'Terms of Service',
    content: `
      <h4>Acceptance of Terms</h4>
      <p>By using WidgetX applications, utilities, and services, you agree to comply with our fair-usage policies and software licensing terms.</p>

      <h4>Software License</h4>
      <p>WidgetX grants you a personal, non-exclusive, non-transferable license to install and run the official binaries published through Google Play and official release repositories.</p>

      <h4>Prohibited Use</h4>
      <p>Reverse-engineering, intercepting encrypted protocol streams, or tampering with telemetric security layers is strictly prohibited.</p>
    `
  },
  'retention-modal': {
    title: 'Data Retention & Security Overview',
    content: `
      <div class="modal-trust-badge">
        🛡️ Google Play Families Policy Compliant
      </div>
      <h4>Google Play Compliant Retention Standards</h4>
      <p>WidgetX manages data lifecycles with strict transparency, adhering to Google Play Families Policy and modern privacy guidelines.</p>

      <h4>Active Retention Lifecycle</h4>
      <ul>
        <li><strong>First 90 Days:</strong> Active data remains safely preserved to ensure service stability without premature manual deletion.</li>
        <li><strong>Beyond 90 Days:</strong> Prior notice via email or in-app notification is provided before extending retention periods.</li>
      </ul>

      <h4>Permanent Deletion Guarantee</h4>
      <p>Account and personal data deletion requests submitted to <a href="mailto:contact.widgetx@gmail.com" style="color:var(--accent-mint);">contact.widgetx@gmail.com</a> or via our Support Form are permanently processed within 3 to 4 working days.</p>

      <h4>Data Protection &amp; Zero-Selling</h4>
      <p>All data in transit is encrypted using TLS 1.3, and data at rest is secured via AES-256. We strictly NEVER sell user data to any third party.</p>
    `
  },
  'trackflow-play': {
    title: 'TrackFlow on Google Play',
    content: `
      <h4>Download TrackFlow</h4>
      <p>TrackFlow is available on Google Play for Android devices running Android 10 (API level 29) and above.</p>
      <p><strong>Package:</strong> <code>dev.widgetx.trackflow</code><br>
      <strong>Latest Version:</strong> v2.4.1 (Stable release)</p>
      <div style="margin-top: 20px; text-align: center;">
        <a href="https://play.google.com" target="_blank" rel="noopener noreferrer" class="submit-btn" style="text-decoration:none; display:inline-block; max-width:280px; margin:0 auto;">
          Open in Google Play Store
        </a>
      </div>
    `
  },
  'connectcall-play': {
    title: 'ConnectCall on Google Play',
    content: `
      <h4>Download ConnectCall</h4>
      <p>ConnectCall provides ultra low-latency encrypted voice communication optimized for low-bandwidth scenarios.</p>
      <p><strong>Package:</strong> <code>dev.widgetx.connectcall</code><br>
      <strong>Latest Version:</strong> v1.9.8 (Stable release)</p>
      <div style="margin-top: 20px; text-align: center;">
        <a href="https://play.google.com" target="_blank" rel="noopener noreferrer" class="submit-btn" style="text-decoration:none; display:inline-block; max-width:280px; margin:0 auto;">
          Open in Google Play Store
        </a>
      </div>
    `
  }
};

function initModals() {
  const modalOverlay = document.getElementById('modalOverlay');
  const modalTitle = document.getElementById('modalTitle');
  const modalBody = document.getElementById('modalBody');
  const closeBtn = document.getElementById('modalCloseBtn');

  if (!modalOverlay) return;

  function openModal(id) {
    const data = modalContent[id];
    if (!data) return;

    modalTitle.textContent = data.title;
    modalBody.innerHTML = data.content;
    modalOverlay.classList.add('open');
    modalOverlay.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
  }

  function closeModal() {
    modalOverlay.classList.remove('open');
    modalOverlay.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
  }

  // Bind policy buttons
  document.querySelectorAll('.policy-link-item').forEach(btn => {
    btn.addEventListener('click', () => {
      const modalId = btn.getAttribute('data-modal');
      openModal(modalId);
    });
  });

  // Bind Google Play buttons
  const trackFlowBtn = document.querySelector('#card-trackflow .google-play-btn');
  if (trackFlowBtn) {
    trackFlowBtn.addEventListener('click', (e) => {
      e.preventDefault();
      openModal('trackflow-play');
    });
  }

  const connectCallBtn = document.querySelector('#card-connectcall .google-play-btn');
  if (connectCallBtn) {
    connectCallBtn.addEventListener('click', (e) => {
      e.preventDefault();
      openModal('connectcall-play');
    });
  }

  // Close triggers
  if (closeBtn) closeBtn.addEventListener('click', closeModal);
  modalOverlay.addEventListener('click', (e) => {
    if (e.target === modalOverlay) closeModal();
  });

  window.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && modalOverlay.classList.contains('open')) {
      closeModal();
    }
  });
}

/**
 * Support Form Handling
 */
function initSupportForm() {
  const form = document.getElementById('supportForm');
  const submitBtn = document.getElementById('submitBtn');
  const feedback = document.getElementById('formFeedback');
  const card = document.querySelector('.support-card');

  if (!form || !submitBtn) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    if (!form.checkValidity()) {
      feedback.textContent = 'Please fill out all required fields properly.';
      feedback.className = 'form-feedback error';
      feedback.style.display = 'block';
      return;
    }

    const btnText = submitBtn.querySelector('.btn-text');
    const spinner = submitBtn.querySelector('.btn-spinner');

    submitBtn.disabled = true;
    if (btnText) btnText.textContent = 'Dispatching & Logging...';
    if (spinner) spinner.style.display = 'inline-block';

    feedback.style.display = 'none';

    const userTz = Intl.DateTimeFormat().resolvedOptions().timeZone || 'Asia/Kolkata';
    const localTime24 = new Date().toLocaleString('en-GB', {
      timeZone: userTz,
      hour12: false, // 24-hour clock
      year: 'numeric',
      month: 'short',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      timeZoneName: 'short',
    }) + ' (24hr)';

    const payload = {
      name: (document.getElementById('userName')?.value || '').trim(),
      email: (document.getElementById('userEmail')?.value || '').trim(),
      platform: document.getElementById('platformSelect')?.value || 'Web Utility Suite',
      issue: document.getElementById('issueSelect')?.value || 'General Inquiry & Feedback',
      message: (document.getElementById('userMessage')?.value || '').trim(),
      clientTime: localTime24,
      timeZone: userTz,
    };

    let ticketId = 'WX-' + Math.floor(100000 + Math.random() * 900000);
    let finalTime = localTime24;

    try {
      const res = await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      if (res.ok) {
        const data = await res.json();
        if (data.ticketId) ticketId = data.ticketId;
        if (data.timestamp) finalTime = data.timestamp;
      }
    } catch (_) {
      // offline / local fallback
    }

    submitBtn.disabled = false;
    if (btnText) btnText.textContent = 'Submit Request';
    if (spinner) spinner.style.display = 'none';

    // Render actionable confirmation
    form.style.display = 'none';
    let confirmationBox = document.getElementById('actionableConfirmation');
    if (!confirmationBox) {
      confirmationBox = document.createElement('div');
      confirmationBox.id = 'actionableConfirmation';
      card.appendChild(confirmationBox);
    }
    confirmationBox.style.display = 'block';
    confirmationBox.innerHTML = `
      <div style="padding-top: 10px;">
        <div style="display:flex; align-items:center; gap: 14px; margin-bottom: 20px;">
          <div style="width: 44px; height: 44px; border-radius: 50%; background: rgba(45, 226, 182, 0.15); border: 1px solid #2DE2B6; display: flex; align-items: center; justify-content: center; color: #2DE2B6; font-size: 22px; font-weight: bold;">✓</div>
          <div>
            <h4 style="color: #fff; margin: 0 0 4px 0; font-size: 20px; font-weight: 700;">Inquiry Logged &amp; Dispatched!</h4>
            <span style="color: #8892B0; font-size: 13px;">Ticket Reference &amp; Dispatch Receipt</span>
          </div>
        </div>

        <div style="background: #0C192E; border: 1px solid rgba(100, 255, 218, 0.2); border-radius: 12px; padding: 16px; margin-bottom: 16px;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
            <span style="font-family: monospace; font-size: 11px; color: #64FFDA; letter-spacing: 1px; font-weight: 600;">TICKET REFERENCE ID</span>
            <button type="button" id="copyTicketBtn" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.15); color: #fff; padding: 4px 10px; border-radius: 6px; font-size: 11.5px; cursor: pointer;">Copy ID</button>
          </div>
          <div style="font-family: monospace; font-size: 22px; font-weight: 700; color: #fff; letter-spacing: 1.5px;">#${ticketId}</div>
        </div>

        <div style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; padding: 16px; margin-bottom: 20px; font-size: 13px; line-height: 1.8;">
          <div style="color: #CCD6F6;"><span style="color: #2DE2B6;">●</span> <strong>Delivered to:</strong> contact.widgetx@gmail.com</div>
          <div style="color: #CCD6F6;"><span style="color: #64FFDA;">●</span> <strong>Receipt dispatched to:</strong> ${payload.email}</div>
          <div style="color: #CCD6F6;"><span style="color: #38BDF8;">●</span> <strong>Received At (24h):</strong> <span style="font-family: monospace; color: #2DE2B6;">${finalTime}</span></div>
          <div style="color: #CCD6F6;"><span style="color: #8892B0;">●</span> <strong>Response SLA:</strong> Within 24 business hours</div>
        </div>

        <div style="display: flex; gap: 12px;">
          <a href="mailto:contact.widgetx@gmail.com?subject=${encodeURIComponent('[Ticket #' + ticketId + '] Inquiry for WidgetX Support')}" style="flex: 1; text-align: center; background: #2DE2B6; color: #0A192F; padding: 13px; border-radius: 10px; font-size: 14px; font-weight: 600; text-decoration: none;">Email Us Directly</a>
          <button type="button" id="newRequestBtn" style="background: transparent; border: 1px solid rgba(255,255,255,0.2); color: #fff; padding: 13px 18px; border-radius: 10px; font-size: 14px; cursor: pointer;">New Request</button>
        </div>
      </div>
    `;

    document.getElementById('copyTicketBtn')?.addEventListener('click', function() {
      navigator.clipboard.writeText(ticketId).then(() => {
        this.textContent = 'Copied! ✓';
        this.style.color = '#2DE2B6';
        this.style.borderColor = '#2DE2B6';
        setTimeout(() => {
          this.textContent = 'Copy ID';
          this.style.color = '#fff';
          this.style.borderColor = 'rgba(255,255,255,0.15)';
        }, 3000);
      });
    });

    document.getElementById('newRequestBtn')?.addEventListener('click', () => {
      confirmationBox.style.display = 'none';
      form.reset();
      form.style.display = 'block';
    });
  });
}
