From: Ian Kent <raven@themaw.net>
Subject: Re: autofs problems with RHEL4
Date: Fri, 19 Oct 2007 15:52:47 +0800
Message-ID: <1192780369.24353.6.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE6D0@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F041EE6D0@permls05.wde.woodside.com.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Thu, 2007-10-18 at 09:25 +0800, Coe, Colin C. (Unix Engineer) wrote:
> 
> Just read the autofs section in http://people.redhat.com/jmoyer
> 
> Attached is the output captured using script. ~330K
> 
> <<typescript>> 
> 
> CC
> 
> _____________________________________________ 
> From:   Coe, Colin C. (Unix Engineer)  
> Sent:   Thursday, 18 October 2007 9:05 AM 
> To:     'autofs@linux.kernel.org' 
> Subject:        autofs problems with RHEL4
> 
> 
> Hi all
> 
> We run 150+ RHEL3 workstations and a handfull of RHEL4 and RHEL5
> boxes.  Our automount maps are served from a Sun One Directory Server
> v5.1, the main automount map contains 1258 entries.
> 
> On RHEL3 (update 9 fully patched) and RHEL5 (fully patched), autofs
> behaves just fine, exactly as we need.  
> 
> On RHEL4 autofs behaves very differently.
> (kernel-smp-2.6.9-55.0.9.EL, autofs-4.1.3-199.3).
> 
> Symptoms: 
> 1) Weirdness with symlinks 
> ls -ld /scratch /scratch/memconf 
> lrwxrwxrwx    1 root     root           20 Sep  4 11:11 /scratch
> -> /nfs/perseus/scratch 
> lrwxrwxrwx    1 root     bin            34 Oct 16
> 05:05 /scratch/memconf -> /nfs/wwwproxy/data/mgmtvol/memconf
> 
> On EL3/5, 'ls -l /scratch/memconf/' will list the contents of the
> directory '/scratch/memconf' points at. 
> On EL4, the first time you do a 'ls -l /scratch/memconf/' will produce
> 'ls: /scratch/memconf/: No such file or directory'.  Repeating the
> command will sometimes give the same error but eventually it will work
> and once working will continue to work until the mounts expire and
> then you're back to square one.
> 
> 2) Different behavior with BASH, <TAB> completions: 
> On EL3/5, typing /scra<TAB> will complete to '/scratch/' 
> On EL4, typing /scra<TAB> will complete to '/scratch ' (note the space
> at the end).
> 
> I know this is minor but the users hate this.

Ya .. and rightly so.

Does the debug log you sent cover a time when you've tried the tab
completion?

If so could you give some indication of when (ie. where) in the log we
should be seeing something happening.

Ian
 

Ian
