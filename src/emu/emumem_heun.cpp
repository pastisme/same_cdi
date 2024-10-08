// license:BSD-3-Clause
// copyright-holders:Olivier Galibert

#include "emu.h"
#include "emumem_hea.h"
#include "emumem_heun.h"

template<int Width, int AddrShift> typename emu::detail::handler_entry_size<Width>::uX handler_entry_read_unmapped<Width, AddrShift>::read(offs_t offset, uX mem_mask) const
{
	return this->m_space->unmap();
}

template<int Width, int AddrShift> std::pair<typename emu::detail::handler_entry_size<Width>::uX, u16> handler_entry_read_unmapped<Width, AddrShift>::read_flags(offs_t offset, uX mem_mask) const
{
	return std::pair<uX, u16>(this->m_space->unmap(), this->m_flags);
}

template<int Width, int AddrShift> std::string handler_entry_read_unmapped<Width, AddrShift>::name() const
{
	return "unmapped";
}


template<int Width, int AddrShift> void handler_entry_write_unmapped<Width, AddrShift>::write(offs_t offset, uX data, uX mem_mask)const { }

template<int Width, int AddrShift> u16 handler_entry_write_unmapped<Width, AddrShift>::write_flags(offs_t offset, uX data, uX mem_mask)const
{
	return this->m_flags;
}

template<int Width, int AddrShift> std::string handler_entry_write_unmapped<Width, AddrShift>::name() const
{
	return "unmapped";
}




template<int Width, int AddrShift> typename emu::detail::handler_entry_size<Width>::uX handler_entry_read_nop<Width, AddrShift>::read(offs_t offset, uX mem_mask) const
{
	return this->m_space->unmap();
}

template<int Width, int AddrShift> std::pair<typename emu::detail::handler_entry_size<Width>::uX, u16> handler_entry_read_nop<Width, AddrShift>::read_flags(offs_t offset, uX mem_mask) const
{
	return std::pair<uX, u16>(this->m_space->unmap(), this->m_flags);
}

template<int Width, int AddrShift> std::string handler_entry_read_nop<Width, AddrShift>::name() const
{
	return "nop";
}


template<int Width, int AddrShift> void handler_entry_write_nop<Width, AddrShift>::write(offs_t offset, uX data, uX mem_mask) const
{
}

template<int Width, int AddrShift> u16 handler_entry_write_nop<Width, AddrShift>::write_flags(offs_t offset, uX data, uX mem_mask) const
{
	return this->m_flags;
}

template<int Width, int AddrShift> std::string handler_entry_write_nop<Width, AddrShift>::name() const
{
	return "nop";
}


template class handler_entry_read_unmapped<0,  1>;
template class handler_entry_read_unmapped<0,  0>;
template class handler_entry_read_unmapped<1,  3>;
template class handler_entry_read_unmapped<1,  0>;
template class handler_entry_read_unmapped<1, -1>;
template class handler_entry_read_unmapped<2,  3>;
template class handler_entry_read_unmapped<2,  0>;
template class handler_entry_read_unmapped<2, -1>;
template class handler_entry_read_unmapped<2, -2>;
template class handler_entry_read_unmapped<3,  0>;
template class handler_entry_read_unmapped<3, -1>;
template class handler_entry_read_unmapped<3, -2>;
template class handler_entry_read_unmapped<3, -3>;

template class handler_entry_write_unmapped<0,  1>;
template class handler_entry_write_unmapped<0,  0>;
template class handler_entry_write_unmapped<1,  3>;
template class handler_entry_write_unmapped<1,  0>;
template class handler_entry_write_unmapped<1, -1>;
template class handler_entry_write_unmapped<2,  3>;
template class handler_entry_write_unmapped<2,  0>;
template class handler_entry_write_unmapped<2, -1>;
template class handler_entry_write_unmapped<2, -2>;
template class handler_entry_write_unmapped<3,  0>;
template class handler_entry_write_unmapped<3, -1>;
template class handler_entry_write_unmapped<3, -2>;
template class handler_entry_write_unmapped<3, -3>;


template class handler_entry_read_nop<0,  1>;
template class handler_entry_read_nop<0,  0>;
template class handler_entry_read_nop<1,  3>;
template class handler_entry_read_nop<1,  0>;
template class handler_entry_read_nop<1, -1>;
template class handler_entry_read_nop<2,  3>;
template class handler_entry_read_nop<2,  0>;
template class handler_entry_read_nop<2, -1>;
template class handler_entry_read_nop<2, -2>;
template class handler_entry_read_nop<3,  0>;
template class handler_entry_read_nop<3, -1>;
template class handler_entry_read_nop<3, -2>;
template class handler_entry_read_nop<3, -3>;

template class handler_entry_write_nop<0,  1>;
template class handler_entry_write_nop<0,  0>;
template class handler_entry_write_nop<1,  3>;
template class handler_entry_write_nop<1,  0>;
template class handler_entry_write_nop<1, -1>;
template class handler_entry_write_nop<2,  3>;
template class handler_entry_write_nop<2,  0>;
template class handler_entry_write_nop<2, -1>;
template class handler_entry_write_nop<2, -2>;
template class handler_entry_write_nop<3,  0>;
template class handler_entry_write_nop<3, -1>;
template class handler_entry_write_nop<3, -2>;
template class handler_entry_write_nop<3, -3>;
