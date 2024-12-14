# Set variables for Xilinx
# Modify this later to take an argument for the version to load
#
function load_xilinx
	set -g XILINX_VERSION 2021.1

	set -g XILINX_VIVADO /opt/Xilinx/Vivado/$XILINX_VERSION
	set -g XILINX_VITIS /opt/Xilinx/Vitis/$XILINX_VERSION
	set -g XILINX_HLS /opt/Xilinx/Vitis_HLS/$XILINX_VERSION
	set -g PATH $XILINX_VITIS/bin \
		$XILINX_VIVADO/bin \
		$XILINX_VITIS/gnu/microblaze/lin/bin \
		$XILINX_VITIS/gnu/arm/lin/bin \
		$XILINX_VITIS/gnu/microblaze/linux_toolchain/lin64_le/bin \
		$XILINX_VITIS/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin \
		$XILINX_VITIS/gnu/aarch32/lin/gcc-arm-none-eabi/bin \
		$XILINX_VITIS/gnu/aarch64/lin/aarch64-linux/bin \
		$XILINX_VITIS/gnu/aarch64/lin/aarch64-none/bin \
		$XILINX_VITIS/gnu/armr5/lin/gcc-arm-none-eabi/bin \
		$XILINX_VITIS/tps/lnx64/cmake-3.3.2/bin \
		$XILINX_VITIS/aietools/bin \
		$XILINX_HLS/bin \
		$PATH
	set -g LM_LICENSE_FILE 2100@xilsrv
	echo "Loaded Xilinx $XV"
end
