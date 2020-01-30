#### 배포용 이미지 빌드 ####
FROM gomicorp/rails:6.0.2.1

RUN gem install passenger && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem \
    && passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --languages ruby

#gem 설치
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# 비즈니스 로직 복사
COPY . .

# 로그 관리 설정 복사
WORKDIR /etc/logrotate.d
COPY ./docker/logrotate/api ./docker/logrotate/serverlog ./

# tmp, log permission
WORKDIR /app
RUN rm -rf /app/tmp && mkdir /app/tmp && chmod o+wx /app/tmp