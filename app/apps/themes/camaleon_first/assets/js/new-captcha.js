function callback(token) {
  console.log(token);
  if (token) {
    document
      .getElementById('smartcaptcha-demo-submit')
      .removeAttribute('disabled');
  } else {
    document
      .getElementById('smartcaptcha-demo-submit')
      .setAttribute('disabled', '1');
  }
}

function smartCaptchaInit() {
  if (!window.smartCaptcha) {
    return;
  }

  window.smartCaptcha.render('captcha-container', {
    sitekey: 'ysc1_B86nHpMRNcbXgLBetGRfc5jx0p6MgAdbw6CEX3Uhb1f42192',
    callback: callback,
  });
}

function smartCaptchaReset() {
  if (!window.smartCaptcha) {
    return;
  }

  window.smartCaptcha.reset();
}

function smartCaptchaGetResponse() {
  if (!window.smartCaptcha) {
    return;
  }

  var resp = window.smartCaptcha.getResponse();
  console.log(resp);
  alert(resp);
}
