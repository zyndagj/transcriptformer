ARG PTTAG=25.10-py3
FROM nvcr.io/nvidia/pytorch:${PTTAG}

ADD transcriptformer /workspace/transcriptformer

RUN pip list | awk '{print$1"=="$2}' | tail +3 > /root/base_constraints.txt && \
    pip install -c /root/base_constraints.txt /workspace/transcriptformer

RUN chmod a+rwX /workspace/transcriptformer
