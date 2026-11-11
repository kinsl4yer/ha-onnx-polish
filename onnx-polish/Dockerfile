FROM lmo3/wyoming-onnx-stt:latest

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Całkowicie nadpisujemy entrypoint
ENTRYPOINT ["/bin/bash"]
CMD ["/run.sh"]
