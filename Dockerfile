FROM continuumio/miniconda3

WORKDIR /app

RUN apt-get update && \
    apt-get install gcc g++ -y

# Create the environment:
COPY /app .
RUN conda env create -f environment.yaml

# Install .
# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "conv_onet", "/bin/bash", "-c"]
RUN python setup.py build_ext --inplace

ENV PATH /opt/conda/envs/conv_onet/bin:$PATH
RUN /bin/bash -c "source activate conv_onet"

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--port=8888"]
