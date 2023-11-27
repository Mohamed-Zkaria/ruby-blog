class Jsonwebtoken
    SECRET_KEY =  Rails.application.credentials.key

    def self.encode(payload, expiry_time = 24.hours.from_now)
        payload[:expiry_time] = expiry_time.to_i
        { token: JWT.encode(payload, SECRET_KEY), expiry_time: expiry_time.strftime("%m-%d-%Y %H:%M")}
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
    end

    def self.valid_token?(expiry_time)
        Time.now < Time.at(expiry_time).to_datetime
    end

end