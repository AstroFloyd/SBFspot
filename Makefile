######################################
# Makefile for SBFspot
#
# Compilation:
#	make
######################################

CC = gcc
CXX = g++
AR = ar
LD = g++

INC = 
CFLAGS = -Wall
RESINC = 
LIBDIR = 
LIB = -lbluetooth -lboost_date_time -lboost_system -lpthread
LDFLAGS = 

CFLAGS += -O2
LDFLAGS += -s
OBJDIR = obj
DEP = 
OUT = bin/SBFspot

OBJ = $(OBJDIR)/boost_ext.o $(OBJDIR)/misc.o $(OBJDIR)/strptime.o $(OBJDIR)/sunrise_sunset.o $(OBJDIR)/SBFNet.o $(OBJDIR)/Bluetooth.o $(OBJDIR)/CSVexport.o $(OBJDIR)/Ethernet.o $(OBJDIR)/EventData.o $(OBJDIR)/ArchData.o $(OBJDIR)/SBFspot.o $(OBJDIR)/TagDefs.o

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

out_release: before_release $(OBJ) $(DEP)
	$(LD) $(LIBDIR) -o $(OUT) $(OBJ)  $(LDFLAGS) $(LIB)

$(OBJDIR)/boost_ext.o: boost_ext.cpp
	$(CXX) $(CFLAGS) $(INC) -c boost_ext.cpp -o $(OBJDIR)/boost_ext.o

$(OBJDIR)/misc.o: misc.cpp
	$(CXX) $(CFLAGS) $(INC) -c misc.cpp -o $(OBJDIR)/misc.o

$(OBJDIR)/strptime.o: strptime.cpp
	$(CXX) $(CFLAGS) $(INC) -c strptime.cpp -o $(OBJDIR)/strptime.o

$(OBJDIR)/sunrise_sunset.o: sunrise_sunset.cpp
	$(CXX) $(CFLAGS) $(INC) -c sunrise_sunset.cpp -o $(OBJDIR)/sunrise_sunset.o

$(OBJDIR)/SBFNet.o: SBFNet.cpp
	$(CXX) $(CFLAGS) $(INC) -c SBFNet.cpp -o $(OBJDIR)/SBFNet.o

$(OBJDIR)/Bluetooth.o: Bluetooth.cpp
	$(CXX) $(CFLAGS) $(INC) -c Bluetooth.cpp -o $(OBJDIR)/Bluetooth.o

$(OBJDIR)/CSVexport.o: CSVexport.cpp
	$(CXX) $(CFLAGS) $(INC) -c CSVexport.cpp -o $(OBJDIR)/CSVexport.o

$(OBJDIR)/Ethernet.o: Ethernet.cpp
	$(CXX) $(CFLAGS) $(INC) -c Ethernet.cpp -o $(OBJDIR)/Ethernet.o

$(OBJDIR)/EventData.o: EventData.cpp
	$(CXX) $(CFLAGS) $(INC) -c EventData.cpp -o $(OBJDIR)/EventData.o

$(OBJDIR)/ArchData.o: ArchData.cpp
	$(CXX) $(CFLAGS) $(INC) -c ArchData.cpp -o $(OBJDIR)/ArchData.o

$(OBJDIR)/SBFspot.o: SBFspot.cpp
	$(CXX) $(CFLAGS) $(INC) -c SBFspot.cpp -o $(OBJDIR)/SBFspot.o

$(OBJDIR)/TagDefs.o: TagDefs.cpp
	$(CXX) $(CFLAGS) $(INC) -c TagDefs.cpp -o $(OBJDIR)/TagDefs.o

clean_release: 
	rm -f $(OBJ) $(OUT)
	rm -rf bin
	rm -rf $(OBJDIR)




.PHONY: before_release after_release clean_release

