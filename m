From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: about mainboard driver
Date: Fri, 7 Jul 2006 10:16:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607071000360.32493@simba.math.ucla.edu>
References: <04cd01c69fe2$d2044bc0$4d74a8c0@jiangguowei2>
	<Pine.LNX.4.64.0607051137470.24272@simba.math.ucla.edu>
	<028d01c6a183$66f1fb00$4d74a8c0@jiangguowei2>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <028d01c6a183$66f1fb00$4d74a8c0@jiangguowei2>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?utf-8?B?5aec5Zu95Lyf?= <jianggw@bsw.net.cn>
Cc: autofs@linux.kernel.org

On Fri, 7 Jul 2006, ??? wrote:

> > I don't think Linux has a specific "mainboard driver" like Windows does; 
> > hardware initialization is done with the subsystems (e.g. memory 
> > management) to which it's relevant, and where necessary the actions are 
> > conditional on the chipset, with both run-time tests and the possibility to 
> > exclude a whole class of processors/chipsets at compile time.
> 
> Hi,Jim .I don't understand your meaning.Could you explain more particularly?

The kernel (.config) has a collection of configuration options so you can 
pick which architecture, and which variants of that architecture, you want 
to compile the kernel for.  These are used to turn on and configure various 
features.  For example, in the x86_64 architecture, you tell it you want 
to support AMD Opteron or Athlon64 and it will define MK8, whereas for an 
Intel Xeon or Pentium-4 with extended memory you would have MPSC defined.
These are then interrogated to set, for example, the level 1 cache line 
size (X86_L1_CACHE_BYTES and X86_L1_CACHE_SHIFT).  These are used in 
./arch/x86_64/kernel/vmlinux.lds.S to align some frequently used kernel 
variables, like "jiffies", for fastest access.  I don't see anyplace else 
where these #defines are used.

As another example, the Via Centaur processor has an onboard crypto engine, 
and you need to set CRYPTO_DEV_PADLOCK to use it, if your kernel may run on 
a Via Centaur.  

The developers try to avoid special cases for particular processors, but
bits and pieces like this are scattered various places around the kernel. 
In Windows there is a specific driver file for each processor type, and I 
don't know any more about what's in it than anyone else outside of 
Microsoft, but I assume that they collect the various special cases in that 
one file.  That's not what Linux does, and you can't identify a particular 
part of the kernel as the "mainboard driver".

I think this discussion is kind of getting off the topic of autofs.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
