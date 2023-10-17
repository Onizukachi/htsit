class YandexCaptchaChecker < ApplicationService
  CAPTCHA_URL = "https://smartcaptcha.yandexcloud.net/validate"
  SMARTCAPTCHA_SERVER_KEY = "ysc2_oLawtS28qfoME9sTvdZtPWLittxL66abQpuhShgTf9d10fba"

  def call
    headers = { "secret": SMARTCAPTCHA_SERVER_KEY, "token": @token }
    headers.merge(ip: @ip) if @ip

    response = RestClient.get("#{CAPTCHA_URL}", headers)

    json_response = JSON.parse response.body

    json_response['status'] == 'ok'
  end

  private

  def initialize(token, ip: nil)
    @token = token
    @ip = ip
  end
end