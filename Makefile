#=====================================================================
#
#          S p e c f e m 3 D  G l o b e  V e r s i o n  7 . 0
#          --------------------------------------------------
#
#     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
#                        Princeton University, USA
#                and CNRS / University of Marseille, France
#                 (there are currently many more authors!)
# (c) Princeton University and CNRS / University of Marseille, April 2014
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
#=====================================================================
#
# Makefile.  Generated from Makefile.in by configure.
#######################################

FC = mpif90
FCFLAGS = -g
FC_DEFINE = -D
MPIFC = mpif90
MPILIBS = 

FLAGS_CHECK =  

FCFLAGS_f90 = -mod ./obj -I./obj -I.  -I. -I${SETUP}

FC_MODEXT = mod
FC_MODDIR = ./obj

FCCOMPILE_CHECK = ${FC} ${FCFLAGS} $(FLAGS_CHECK)

MPIFCCOMPILE_CHECK = ${MPIFC} ${FCFLAGS} $(FLAGS_CHECK)

CC = icc
CFLAGS = -g -O2
CPPFLAGS = -I${SETUP} 

FCLINK = $(MPIFCCOMPILE_CHECK)

#######################################
####
#### MPI
####
#######################################

## MPI directories for CUDA / OpenCL
MPI_INCLUDES = 

#######################################
####
#### GPU
#### with configure: ./configure --with-cuda=cuda5 CUDA_FLAGS=.. CUDA_LIB=.. CUDA_INC=.. MPI_INC=.. ..
#### with configure: ./configure --with-opencl OCL_GPU_FLAGS=.. OCL_LIB=.. OCL_INC=.. MPI_INC=.. ..
####
#######################################

# Reduce GPU-register pressure by limited the number of thread spread
# (GPU for embedded devices are not powerful enough for big kernels)
# Must match mesh_constants_gpu.h::GPU_ELEM_PER_THREAD
GPU_ELEM_PER_THREAD := 1

##
## CUDA
##
#CUDA = yes
CUDA = no

#CUDA5 = yes
CUDA5 = no

#CUDA6 = yes
CUDA6 = no

#CUDA7 = yes
CUDA7 = no

#CUDA8 = yes
CUDA8 = no

#CUDA9 = yes
CUDA9 = no

# CUDA compilation with linking
#CUDA_PLUS = yes
CUDA_PLUS = no

# default cuda libraries
# runtime library -lcudart needed, others are optional -lcuda -lcublas

CUDA_FLAGS = 
CUDA_INC = 
CUDA_LINK =   -lstdc++
CUDA_DEBUG = --cudart=shared

#NVCC = nvcc
NVCC = icc

##
## GPU architecture
##
# CUDA architecture / code version
# Fermi: -gencode=arch=compute_10,code=sm_10 not supported
# Tesla (default): -gencode=arch=compute_20,code=sm_20
# Geforce GT 650m: -gencode=arch=compute_30,code=sm_30
# Kepler (cuda5,K20) : -gencode=arch=compute_35,code=sm_35
# Kepler (cuda6.5,K80): -gencode=arch=compute_37,code=sm_37
# Maxwell (cuda7,K2200): -gencode=arch=compute_50,code=sm_50
# Pascal (cuda8,P100): -gencode=arch=compute_60,code=sm_60
# Volta (cuda9,V100): -gencode=arch=compute_70,code=sm_70
GENCODE_20 = -gencode=arch=compute_20,code=\"sm_20,compute_20\"
GENCODE_30 = -gencode=arch=compute_30,code=\"sm_30,compute_30\"
GENCODE_35 = -gencode=arch=compute_35,code=\"sm_35,compute_35\"
GENCODE_37 = -gencode=arch=compute_37,code=\"sm_37\"
GENCODE_50 = -gencode=arch=compute_50,code=\"sm_50,compute_50\"
GENCODE_60 = -gencode=arch=compute_60,code=\"sm_60,compute_60\"
GENCODE_70 = -gencode=arch=compute_70,code=\"sm_70,compute_70\"

# cuda preprocessor flag
# CUDA version 9.0
##GENCODE = $(GENCODE_70) $(FC_DEFINE)GPU_DEVICE_Volta
# CUDA version 8.0
##GENCODE = $(GENCODE_60) $(FC_DEFINE)GPU_DEVICE_Pascal
# CUDA version 7.x
##GENCODE = $(GENCODE_50) $(FC_DEFINE)GPU_DEVICE_Maxwell
# CUDA version 6.5
##GENCODE = $(GENCODE_37) $(FC_DEFINE)GPU_DEVICE_K80
# CUDA version 5.x
##GENCODE = $(GENCODE_35) $(FC_DEFINE)GPU_DEVICE_K20
# CUDA version 4.x
#GENCODE = $(GENCODE_20)

# CUDA flags and linking
#NVCC_FLAGS_BASE = $(CUDA_FLAGS) $(CUDA_INC) $(CUDA_DEBUG) $(MPI_INCLUDES)
##NVCC_FLAGS = $(NVCC_FLAGS_BASE) -dc $(GENCODE)
#NVCC_FLAGS = $(NVCC_FLAGS_BASE) -DUSE_OLDER_CUDA4_GPU $(GENCODE)

#NVCCLINK_BASE = $(NVCC) $(CUDA_INC) $(MPI_INCLUDES)
##NVCCLINK = $(NVCCLINK_BASE) -dlink $(GENCODE)
#NVCCLINK = $(NVCCLINK_BASE) -DUSE_OLDER_CUDA4_GPU $(GENCODE)

NVCC_FLAGS =
NVCCLINK = $(NVCC) $(NVCC_FLAGS)

##
## OpenCL
##
#OCL = yes
OCL = no

OCL_CPU_FLAGS =  $(MPI_INCLUDES)
OCL_GPU_FLAGS = 

OCL_INC = 
OCL_LINK =  

ifeq ($(OCL), yes)
  ifeq ($(CUDA), yes)
    GPU_CUDA_AND_OCL = yes
  endif
endif

ifeq ($(OCL), no)
  ifeq ($(CUDA), no)
    NO_GPU = yes
  endif
endif

ifneq ($(NO_GPU), yes)
  HAS_GPU = yes
endif

#######################################
####
#### MIC
#### with configure: ./configure --with-mic
####
#######################################

# native compilation
#MIC = yes
MIC = no

#MIC_FLAGS = -mmic #-qopt-report2 -qopt-report-phase=vec
MIC_FLAGS =

FCFLAGS += $(MIC_FLAGS)
CPPFLAGS += $(MIC_FLAGS)

#######################################
####
#### LIBXSMM
#### with configure: ./configure --with-xsmm LIBXSMM_INC=/opt/libxsmm/include \
####                                         LIBXSMM_LIBS=/opt/libxsmm/lib \
####                                         BLAS_LIBS=/opt/local/lib/lapack
####
#######################################

#XSMM = yes
XSMM = no

#FCFLAGS += $(FC_DEFINE)XSMM -I
#MPILIBS += -L -lxsmmf -lxsmm -L -lblas

#######################################
####
#### OpenMP
#### with configure: ./configure --enable-openmp
####
#######################################

#OPENMP = yes
OPENMP = no

#OMP_FLAGS =  $(FC_DEFINE)USE_OPENMP #$(FC_DEFINE)USE_OPENMP_ATOMIC_INSTEAD_OF_CRITICAL
OMP_FLAGS =

FCFLAGS += $(OMP_FLAGS)

#######################################
####
#### VTK
#### with configure: ./configure --enable-vtk ..
####
#######################################

#VTK = yes
VTK = no

CPPFLAGS += 
LDFLAGS += 
MPILIBS += 

#######################################
####
#### ADIOS
#### with configure: ./configure --with-adios ADIOS_CONFIG=..
####
#######################################

#ADIOS = yes
ADIOS = no

#ADIOS_DEF = $(FC_DEFINE)ADIOS_INPUT
ADIOS_DEF =

FCFLAGS += 
MPILIBS += 

#######################################
####
#### ASDF
#### with configure: ./configure --with-asdf ASDF_LIBS=..
####
#######################################

#ASDF = yes
ASDF = no

#FCFLAGS += @ASDF_FCFLAGS@
MPILIBS += 

#######################################
####
#### FORCE_VECTORIZATION
#### with configure: ./configure --with-vec ..
####
#######################################
#FORCE_VECTORIZATION = yes
FORCE_VECTORIZATION = no

#######################################
####
#### CEM
#### with configure: ./configure --with-cem CEM_LIBS=.. CEM_FCFLAGS=..
####
#######################################

#CEM = yes
CEM = no

FCFLAGS += 
MPILIBS += 


#######################################
####
#### directories
####
#######################################

## compilation directories
# B : build directory
B = .
# E : executables directory
E = $B/bin
# O : objects directory
O = $B/obj
# S_TOP : source file root directory
S_TOP = .
# L : libraries directory
L = $B/lib
# setup file directory
SETUP = $B/setup
# output file directory
OUTPUT = $B/OUTPUT_FILES


#######################################
####
#### targets
####
#######################################

# code subdirectories
SUBDIRS = \
	shared \
	create_header_file \
	meshfem3D \
	specfem3D \
	auxiliaries \
	tomography/postprocess_sensitivity_kernels \
	tomography \
	$(EMPTY_MACRO)

ifeq ($(HAS_GPU),yes)
  SUBDIRS := gpu $(SUBDIRS)
endif

# default targets
DEFAULT = \
	xcreate_header_file \
	xmeshfem3D \
	xspecfem3D \
	xcombine_AVS_DX \
	xcombine_surf_data \
	xcombine_vol_data \
	xcombine_vol_data_vtk \
	xconvolve_source_timefunction \
	xcreate_movie_AVS_DX \
	xcreate_movie_GMT_global \
	xwrite_profile \
	$(EMPTY_MACRO)

ifeq ($(ADIOS), yes)
DEFAULT += 	\
	xcombine_vol_data_adios \
	xcombine_vol_data_vtk_adios \
	$(EMPTY_MACRO)
endif

all: default aux movies postprocess tomography

default: $(DEFAULT)

ifdef CLEAN
clean:
	@echo "cleaning by CLEAN"
	-rm -f $(foreach dir, $(CLEAN), $($(dir)_OBJECTS) $($(dir)_MODULES) $($(dir)_SHARED_OBJECTS) $($(dir)_TARGETS))
	-rm -f ${E}/*__genmod.*
	-rm -f ${O}/*__genmod.*
else
clean:
	@echo "cleaning all"
	-rm -f $(foreach dir, $(SUBDIRS), $($(dir)_OBJECTS) $($(dir)_MODULES) $($(dir)_TARGETS))
	-rm -f ${E}/*__genmod.*
	-rm -f ${O}/*__genmod.*
endif

realclean: clean
	-rm -rf $E/* $O/*

mrproper: clean

# unit testing
# If the first argument is "test"...
ifeq (test,$(findstring test,firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  TEST_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # turn them into do-nothing targets
  $(eval $(TEST_ARGS):;@:)
endif

tests:
	@echo "testing in directory: ${S_TOP}/tests/"
	cd ${S_TOP}/tests; ./run_all_tests.sh $(TEST_ARGS)
	@echo ""

help:
	@echo "usage: make [executable]"
	@echo ""
	@echo "supported main executables:"
	@echo "    xmeshfem3D"
	@echo "    xspecfem3D"
	@echo ""
	@echo "defaults:"
	@echo "    xcreate_header_file"
	@echo "    xmeshfem3D"
	@echo "    xspecfem3D"
	@echo "    xcombine_AVS_DX"
	@echo "    xcombine_surf_data"
	@echo "    xcombine_vol_data"
	@echo "    xcombine_vol_data_vtk"
	@echo "    xconvolve_source_timefunction"
	@echo "    xcreate_movie_AVS_DX"
	@echo "    xcreate_movie_GMT_global"
	@echo "    xwrite_profile"
	@echo ""
	@echo "additional executables:"
	@echo "- auxiliary executables: [make aux]"
	@echo "    xcombine_vol_data"
	@echo "    xcombine_vol_data_vtk"
ifeq ($(ADIOS), yes)
	@echo "    xcombine_vol_data_adios"
	@echo "    xcombine_vol_data_vtk_adios"
endif
	@echo "    xcombine_surf_data"
	@echo "    xcombine_AVS_DX"
	@echo "    xconvolve_source_timefunction"
	@echo "    xwrite_profile"
	@echo ""
	@echo "- movie executables: [make movies]"
	@echo "    xcreate_movie_AVS_DX"
	@echo "    xcreate_movie_GMT_global"
	@echo "    xcombine_paraview_strain_data"
	@echo ""
	@echo "- sensitivity kernel postprocessing tools: [make postprocess]"
	@echo "    xaddition_sem"
	@echo "    xclip_sem"
	@echo "    xcombine_sem"
	@echo "    xcreate_cross_section"
	@echo "    xdifference_sem"
	@echo "    xinterpolate_model"
	@echo "    xsmooth_sem"
ifeq ($(ADIOS), yes)
	@echo "    xconvert_model_file_adios"
endif
	@echo ""
	@echo "- tomography tools: [make tomography]"
	@echo "    xadd_model_iso"
	@echo "    xadd_model_tiso"
	@echo "    xadd_model_tiso_cg"
	@echo "    xadd_model_tiso_iso"
	@echo "    xsum_kernels"
	@echo "    xsum_preconditioned_kernels"
	@echo ""
	@echo "for unit testing:"
	@echo "    tests"
	@echo ""

.PHONY: all default clean realclean help tests

#######################################

${SETUP}/version.fh: ./.git/logs/HEAD
	@echo "GEN $@"
	@echo "! This file is generated by Make. Do not edit this file!" > $@
	@echo "character(len=*), parameter :: git_version = \"$$(cd ${S_TOP} && git describe --tags)\"" >> $@

#######################################


# Get dependencies and rules for building stuff
include $(patsubst %, ${S_TOP}/src/%/rules.mk, $(SUBDIRS))


#######################################

##
## Shortcuts
##

# Shortcut for: <prog>/<xprog> -> bin/<xprog>
define target_shortcut
$(patsubst $E/%, %, $(1)): $(1)
.PHONY: $(patsubst $E/%, %, $(1))
$(patsubst $E/x%, %, $(1)): $(1)
.PHONY: $(patsubst $E/x%, %, $(1))
endef

# Shortcut for: dir -> src/dir/<targets in here>
define shortcut
$(1): $($(1)_TARGETS)
.PHONY: $(1)
$$(foreach target, $$(filter $E/%,$$($(1)_TARGETS)), $$(eval $$(call target_shortcut,$$(target))))
endef

$(foreach dir, $(SUBDIRS), $(eval $(call shortcut,$(dir))))

# testing
test : tests

# Other old shortcuts
mesh: $E/xmeshfem3D
spec: $E/xspecfem3D

.PHONY: mesh spec

