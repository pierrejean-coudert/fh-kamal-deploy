FROM python:3.12-slim

ARG USERNAME=fasthtml
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME


# install curl for uv
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ADD --chmod=755 https://astral.sh/uv/install.sh /install.sh
RUN /install.sh && rm /install.sh


WORKDIR /app

COPY requirements.txt .
RUN /root/.cargo/bin/uv pip install --system --no-cache -r requirements.txt

COPY . .

RUN chown -R $USERNAME:$USERNAME /app
USER $USERNAME

EXPOSE 8000

CMD ["python", "main.py"]