From: raven@themaw.net
Subject: Re: Program map and submount problem
Date: Sat, 24 Jan 2004 21:07:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401242045100.1799@raven.themaw.net>
References: <200401232038.i0NKc9pK019108@miguelito.qualcomm.com>
 <Pine.LNX.4.58.0401241101370.1751@raven.themaw.net>
 <56E74918-4E25-11D8-9520-000A95A011F0@qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <56E74918-4E25-11D8-9520-000A95A011F0@qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Fri, 23 Jan 2004, Mike Marion wrote:

> 
> The program works exactly like expected, and has been working for quite 
> some time.  This is either a problem that didn't exist before, or we 
> just somenow never triggered it before.

Cool.

> 
> I found out that if you just cd into the path and sit there, it'll trip 
> the bug, no need to have one of the NFS mounts below it triggered at 
> all.

I had a feeling I'd had this type of trouble before and sure enough I 
have. Worse I never fixed it.

The problem has always been there and perhaps you have not triggered it 
before.

It happens because the daemon thinks that if all mounts under the mount 
point are not busy it can umount the submount (there must be an 
-fstype=autofs there somewhere yes, probably 
/usr/local/projects/some/automount/submount itself I hope) itself. Or you 
are trying to shutdown the top mount when it is busy in the same way. I 
think you'll get the same result.

The daemon can't identify that the mount point itself is busy as it uses 
the entries in mtab to work out if there is more to expire. So onward and 
downward it goes.

But it can't complete the umount of course because, it itself is busy. 
Anything like a program with an open file handle on the directory or a 
process with it as pwd will cause this.

The gotya is that if it gets to the umount stage it's already to late to 
save it.

Ahh, he says, I put an ioctl in the kernel module ages ago, for this very 
reason, but never implemented its intended use.

Bottom line is that I can fix this for 4.1.1 (out soonish) combined with 
my kernel module only. So, sorry to those that can't or have chosen not to 
upgrade there module. I can't think of a more general way to fix it.

Are up for testing the fix Mike?

Ian
