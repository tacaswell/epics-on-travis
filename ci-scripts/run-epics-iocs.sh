#!/bin/bash
set -e -x

. $CI_SCRIPTS/epics-config.sh

run_ioc "$PYEPICS_IOC_PIPE" "pyepics-test-ioc" "${PYEPICS_IOC}/iocBoot/iocTestioc" \
    "${PYEPICS_IOC}/bin/${EPICS_HOST_ARCH}/testioc ./st.cmd" "Py:ao1"

run_ioc "$MOTORSIM_IOC_PIPE" "motorsim-ioc" "${MOTORSIM_IOC}/iocBoot/ioclocalhost" \
    "${MOTORSIM_IOC}/bin/${EPICS_HOST_ARCH}/mtrSim ./st.cmd" "sim:mtr1"

echo "Starting the ADSim IOC..."

run_ioc "$ADSIM_IOC_PIPE" "adsim-ioc" "${ADSIM_IOC}/iocBoot/iocSimDetector" \
    "${ADSIM_IOC}/bin/${EPICS_HOST_ARCH}/simDetectorApp ./st.cmd" "13SIM1:image1:PluginType_RBV"
# run_ioc "$PVA_IOC_PIPE" "pva-combined-ioc" "${IOCS}/pva2pva/iocBoot/iocwfdemo" \
#     "${PVA_PATH}/bin/${EPICS_HOST_ARCH}/softIocPVA ./st.cmd" ""

echo "All IOCs are running!"
