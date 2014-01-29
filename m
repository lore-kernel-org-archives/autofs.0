From: Donald Buczek <buczek@molgen.mpg.de>
Subject: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Wed, 29 Jan 2014 17:02:47 +0100
Message-ID: <52E92627.9050801@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs <autofs@vger.kernel.org>

Hello,

we are trying to switch from amd to autofs. After successfully testing 
and rolling it out to the first several machines, from time to time we 
get directories stuck with "Too many levels of symbolic links" on a path 
which should be automounted via an indirect map.

linux 3.8.13
autofs 5.0.8

As an example, here is data from a system where the path /scratch/tmp is 
stuck:

http://www.molgen.mpg.de/~buczek/autofs-demo/

   auto.master    # master map
   auto.scratch    # indirect map for /scratch
   autofs            # from /etc/defaults
   typescript       # shows the problem and a bit of gdb dump of kernel 
structures
   typescript.l     # same with line numbers for reference
   gdb-macros     # macros used in the gdb session

 From typescript.l , line 122ff it is clear, that /scratch/tmp is not 
currently mounted. On the other hand, the gdb session finds the dentry 
of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is 
DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS 
with DCACHE_MOUNTED indicating that there should be something mounted 
there(?). I think, this state is faulty and necessarily leads to ELOOP 
during path walk. Probably the situation is known by the gurus here?

Is there any known bug which can lead to this situation? Any advice?

Thank you

   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

