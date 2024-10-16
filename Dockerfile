# Use a Python and Node.js base image
FROM nikolaik/python-nodejs:python3.10-nodejs19

# Install necessary packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app/

# Copy the application files
COPY . .

# Upgrade pip and install dependencies
RUN python -m pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt  # Fixed from pip3 to pip for consistency

# Expose the necessary port
EXPOSE 8001

# Add a health check to ensure the app is running
HEALTHCHECK CMD curl --fail http://localhost:8001/health || exit 1

# Command to run the application
CMD ["python", "-m", "VIPMUSIC"]
