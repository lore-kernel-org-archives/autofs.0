From: raven@themaw.net
Subject: Re: Program map and submount problem
Date: Sat, 24 Jan 2004 11:19:16 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401241101370.1751@raven.themaw.net>
References: <200401232038.i0NKc9pK019108@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401232038.i0NKc9pK019108@miguelito.qualcomm.com>
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
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

On Fri, 23 Jan 2004 mmarion@qualcomm.com wrote:

> On 23 Jan, Ian Kent wrote:
> 
> Hmm... for some reason I got 28 copies of this msg.. odd.

Sorry, but there's probably not much I can do about it.

ISPs mail server becomes more broken every day.

Maybe it's pine but I done think so.

> 
> > On Fri, 23 Jan 2004, Mike Marion wrote:
> 
> >> Jan 22 23:49:23 linux-glab-1 automount[2171]: shut down, path = 
> >> /usr/local/projects/some/automount/submount
> >> Jan 22 23:49:23 linux-glab-1 automount[2171]: failed to remove dir 
> >> /usr/local/projects/some/automount/submount: Device or resource busy
> > 
> > What does auto.projects.sh issue when executed in this context.
> 
> Not sure what you mean.  Do you mean what options did it startup the submount
> with when it mounted to the /usr/local/projects/some/automount/submount point?

The program must return a valid map. What does it return when you run it 
manually with expected inputs. eg. auto.projects.sh bin.

> If so:
> /usr/sbin/automount --submount /usr/local/projects/some/automount/submount program /etc/auto.projects.sh 60 -Dpref=
> 
> The -Dpref= option is a leftover from the original autofsv3 script, I
> believe.  I'm trying a test without that to see if it makes any
> difference but I doubt it.  Also going to strace the daemon on the
> submount point to see what it does before quitting.

That's probably not going to help much but worth a try.

> 
> > What mounts work fine. 
> 
> I meant that before the problem occurs, I can do something like:
> $ cd /usr/local/projects/some/automount/submount
> $ ls -l bin lib
> and see the contents of bin and lib, which are NFS mountpoints off of that
> path.  After those points (bin and lib) expire, automount tries to expire the
> submount point, and that's when the problem occurs.  The problem appears to be 
> the automount daemon for /usr/local/projects/some/automount/submount will exit,
> even though the path is still busy.  This causes the umount of the path
> (.../some/automount/submount) to fail, which then makes that path (and any NFS 
> mounts below it) inaccessible.

Ah. You don't mean submount in the sence I think of it. When you say 
submount I think of the mount itself being an autofs mount. Lets call 
these normal automounts.

So it appears what we are talking about the expire failing.

It appears you are using 4.1.0 but what kernel module?

There are numerous places the daemon will cowardly exit. Leaving them in 
or taking them out are both bad as if it doesn't exit the confusion will 
increase causing a worse problem. So I've left them in for now. 

The bottom line is that I will need to duplicate the problem in order to 
solve it. If you are willing to provide the script it may be easier for me 
to do that. Otherwise I'm in the dark about what is actually going on.

> 
> The log messages make it appear that the automount daemon on
> /usr/local/projects/some/automount/submount is trying to umount itself without
> bothering to see if it's a busy path or not.  It seems to assume that since
> there are no submounts (either autofs or NFS) below it, that it's not busy.

Or there has been a failure and the daemon is trying to blindly exit and 
not able to.

Ian
