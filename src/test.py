import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

RING_005  = 0b100000
RING_011  = 0b010000
RING_023  = 0b001000
RING_047  = 0b000100
RING_097  = 0b000010
RING_197  = 0b000001
RING_CLK  = 0b000000
RING_END  = 0b111111
CYCLES    = 8

@cocotb.test()
async def test_my_design( dut ):
    dut._log.info( "start" )
    clock = Clock( dut.clk, 20, units="ns" )
    cocotb.start_soon( clock.start() )

    dut.ena.value     = 1
    dut.ui_in.value   = 0

    dut.rst_n.value = 0
    await ClockCycles( dut.clk, 10 )
    dut.rst_n.value = 1
    await ClockCycles( dut.clk, CYCLES )

    dut._log.info( "Starting 005 test" )
    dut.uio_in.value  = RING_005
    await ClockCycles( dut.clk, CYCLES * 3 )

    dut._log.info( "Starting 011 test" )
    dut.uio_in.value  = RING_011
    await ClockCycles( dut.clk, CYCLES * 3 )

    dut._log.info( "Starting 023 test" )
    dut.uio_in.value  = RING_023
    await ClockCycles( dut.clk, CYCLES * 3 )

    dut._log.info( "Starting 047 test" )
    dut.uio_in.value  = RING_047
    await ClockCycles( dut.clk, CYCLES * 3 )

    dut._log.info( "Starting 097 test" )
    dut.uio_in.value  = RING_097
    await ClockCycles( dut.clk, CYCLES * 4 )

    dut._log.info( "Starting 197 test" )
    dut.uio_in.value  = RING_197
    await ClockCycles( dut.clk, CYCLES * 8 )

    dut._log.info( "Starting CLK test" )
    dut.uio_in.value  = RING_CLK
    await ClockCycles( dut.clk, CYCLES * 4 )

    dut._log.info( "End tests" )
    dut.uio_in.value  = RING_END
    await ClockCycles( dut.clk, 2 )
