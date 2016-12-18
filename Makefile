######################################
# Makefile for SBFspot
#
# Compilation:
#	make
######################################

CXX = g++
LD = g++

CFLAGS = -Wall
LIB = -lbluetooth -lboost_date_time -lboost_system -lpthread

CFLAGS += -O2
LDFLAGS = -s
OBJDIR = obj
SRCDIR = src
OUT = bin/SBFspot

OBJ = $(OBJDIR)/boost_ext.o $(OBJDIR)/misc.o $(OBJDIR)/strptime.o $(OBJDIR)/sunrise_sunset.o $(OBJDIR)/SBFNet.o $(OBJDIR)/Bluetooth.o \
	$(OBJDIR)/CSVexport.o $(OBJDIR)/Ethernet.o $(OBJDIR)/EventData.o $(OBJDIR)/ArchData.o $(OBJDIR)/SBFspot.o $(OBJDIR)/TagDefs.o

all: release

clean: clean_release 

before_release: 
	test -d bin || mkdir -p bin
	test -d $(OBJDIR) || mkdir -p $(OBJDIR)

after_release: 
	cp files/TagList*.txt bin
	cp files/date_time_zonespec.csv bin
	cp files/SBFspot.cfg bin

release: before_release out_release after_release

out_release: before_release $(OBJ)
	$(LD) -o $(OUT) $(OBJ)  $(LDFLAGS) $(LIB)


$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CFLAGS) -c $< -o $@


clean_release: 
	rm -f $(OBJ) $(OUT)
	rm -rf bin
	rm -rf $(OBJDIR)




.PHONY: before_release after_release clean_release

