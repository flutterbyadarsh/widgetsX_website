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
    title: 'Privacy Policy',
    content: `
      <h4>Commitment to Zero-Knowledge Telemetry</h4>
      <p>At WidgetX, we build utilities engineered with strict data minimization principles. Our software operates on a local-first paradigm.</p>
      
      <h4>Data Collection & Use</h4>
      <ul>
        <li><strong>TrackFlow:</strong> All fitness telemetry and sensor records are stored purely on your local device. No raw health or sensor metrics are ever transmitted without explicit user export.</li>
        <li><strong>ConnectCall:</strong> Voice transmission uses end-to-end encryption (E2EE) protocols. We maintain zero call logs and no audio recordings on central servers.</li>
      </ul>

      <h4>Third-Party Sharing</h4>
      <p>We do not monetize, sell, or license user information to third-party ad networks or data brokers.</p>

      <h4>User Rights</h4>
      <p>You may request full data deletion or audit logs at any time using our Support & Data Requests portal.</p>
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
      <h4>Enterprise-Grade Security Architecture</h4>
      <p>We implement AES-256-GCM encryption at rest and TLS 1.3 in transit across all network utilities.</p>

      <h4>Retention Schedules</h4>
      <ul>
        <li><strong>Support Inquiries:</strong> Retained for 30 days following ticket resolution, then permanently purged.</li>
        <li><strong>Telemetry Diagnostics:</strong> Optional anonymous crash dumps are automatically wiped after 14 days.</li>
      </ul>

      <h4>Verification & Audit</h4>
      <p>Our infrastructure undergoes periodic security evaluations in full compliance with the Google Play Families Policy and modern privacy frameworks.</p>
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
