FROM python:3.12.3-slim
WORKDIR /app
COPY /build/requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
COPY . .
# RUN groupadd -r -g 3000 robot && useradd -r -g 3000 -u 3000 robot && \
# chsh -s /usr/sbin/nologin root && find /app -type d -exec chmod 757 {} \; && find /app -type f -exec chmod 757 {} \;
ENV TZ="Asia/Ho_Chi_Minh"
# USER 3000
CMD ["uvicorn", "main:app","--reload", "--host", "0.0.0.0", "--port", "5000"]
