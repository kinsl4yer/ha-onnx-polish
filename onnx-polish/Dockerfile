FROM lmo3/wyoming-onnx-stt:latest

COPY run.sh /run.sh
RUN chmod +x /run.sh

# Drop the base image entrypoint so both models are not started implicitly.
ENTRYPOINT []
CMD ["/bin/bash", "/run.sh"]
