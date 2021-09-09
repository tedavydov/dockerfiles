
# starting with a base image containing the complete Python interpreter and its packages 
FROM python:3.8 AS builder

# installing dependencies
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# creation of a new minimalistic image
FROM python:3.8-slim
WORKDIR /code

# copy only dependencies and code into a new image (multi-stage build)
# this will reduce the size of the finished image
COPY --from=builder /root/.local /root/.local
COPY .src .

# set the environment variable
ENV PATH=/root/.local:$PATH

# execution command
CMD ["python", "-u", "./app.py"]

