FROM bars21/dev_base as dev_hep_root
COPY --from=bars21/dev_base $COMMON_BUILD_PREFIX $COMMON_BUILD_PREFIX
COPY --from=bars21/dev_base $COMMON_INSTALL_PREFIX $COMMON_INSTALL_PREFIX
## ROOT 6.*
ENV ROOT_VER=6.24.00
RUN . $COMMON_INSTALL_PREFIX/setup.sh && \
    cd $COMMON_BUILD_PREFIX && \
    wget https://root.cern/download/root_v${ROOT_VER}.source.tar.gz && \
    tar -xf root_*tar.gz && \
    mkdir root_build  && \
    cd root_build  && \
    cmake3 ../root-6* -DCMAKE_INSTALL_PREFIX=$COMMON_INSTALL_PREFIX && \
    make -j3 install && \
    cd $COMMON_BUILD_PREFIX && \
    rm -rf $COMMON_BUILD_PREFIX/* && \
    echo "source $COMMON_INSTALL_PREFIX/bin/thisroot.sh" >> $COMMON_INSTALL_PREFIX/setup.sh
