FROM python:3.12.3-slim
WORKDIR /app
COPY /build/requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
RUN pip list
COPY . .
RUN groupadd -r -g 3000 robot && useradd -r -g 3000 -u 3000 robot && \
  chsh -s /usr/sbin/nologin root && chown -R robot:robot /app && chmod -R 755 /app
ENV TZ="Asia/Ho_Chi_Minh"
USER 3000
CMD ["uvicorn", "main:app","--reload", "--host", "0.0.0.0", "--port", "5000"]
