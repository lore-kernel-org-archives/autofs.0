From: mmarion@qualcomm.com
Subject: Re: /net with program map problem on x86_64
Date: Mon, 8 Mar 2004 14:54:05 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403082254.i28Ms5gQ023371@miguelito.qualcomm.com>
References: <200403082206.i28M6PgQ016051@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403082206.i28M6PgQ016051@miguelito.qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  8 Mar, To: autofs@linux.kernel.org wrote:

>> Kernel module version?
> 
> It's not syslogging properly since the change to the stdarg stuff, but it's
> the same patch in the autofs4-2.4-module-20031201.tar.bz2 file... 4.04?

*sigh*... nevermind.  Turns out that while I was re-imaging this box over and
over (getting pxe->suse autoyast->Qualcomm bits) going, I forgot to uncomment
the 
# alias autofs autofs4
line in the modules.conf file... again.  So it was using the crappy older
autofs module code with the new daemon.

I just rebooted with the modules.conf corrected, and /net works now..

mmarion @ rs-blade 51 [~]% ls -l
/net/mig/local/mnt/workspace/src/linux-2.4.24.tar.bz2 
-rw-------    1 mmarion  sysadmin 29837818 2004-01-09 14:26
/net/mig/local/mnt/workspace/src/linux-2.4.24.tar.bz2
mmarion @ rs-blade 52 [~]% df !$
df /net/mig/local/mnt/workspace/src/linux-2.4.24.tar.bz2
Filesystem           1K-blocks      Used Available Use% Mounted on
mig:/local/mnt        17413280  10444256   6794880  61% /net/mig/local/mnt

Sorry for making you think there was another bug. :)

I should just rebuild my kernel and leave out autofs (not 4) alltogether so
this can't happen again.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
What goes up, must come down. Ask any system administrator.
