From: mmarion@qualcomm.com
Subject: Re: Program map and submount problem
Date: Fri, 23 Jan 2004 15:48:19 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401232348.i0NNmJN4021507@miguelito.qualcomm.com>
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
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On 23 Jan, To: raven@themaw.net wrote:

> The log messages make it appear that the automount daemon on
> /usr/local/projects/some/automount/submount is trying to umount itself without
> bothering to see if it's a busy path or not.  It seems to assume that since
> there are no submounts (either autofs or NFS) below it, that it's not busy.

Recomipled autofs on test box with debugging enabled.  Syslog output of point
where it umounts NFS children (under
/usr/local/projects/some/automount/submount) and then the daemon on submount
tries to umount, fails, and exits follows:

Jan 23 15:07:49 linux-glab-1 automount[19686]: sig 14 switching from 1 to 2
Jan 23 15:07:49 linux-glab-1 automount[19686]: get_pkt: state 1, next 2
Jan 23 15:07:49 linux-glab-1 automount[19686]: st_expire(): state = 1 
Jan 23 15:07:49 linux-glab-1 automount[19686]: expire_proc: exp_proc=20254
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet: type = 2 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet_expire_multi: token 518, name tools 
Jan 23 15:07:49 linux-glab-1 automount[20255]: umount_multi: path=/usr/local/projects/some/automount/submount/tools incl=1 
Jan 23 15:07:49 linux-glab-1 automount[20255]: umount_multi: unmounting dir=/usr/local/projects/some/automount/submount/tools 
Jan 23 15:07:49 linux-glab-1 automount[20255]: rm_unwanted: /usr/local/projects/some/automount/submount/tools 
Jan 23 15:07:49 linux-glab-1 automount[20255]: expired /usr/local/projects/some/automount/submount/tools
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_child: got pid 20255, sig 0 (0), stat 0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: sig_child: found pending op pid 20255: signalled 0 (sig 0), exit status 0
Jan 23 15:07:49 linux-glab-1 automount[19686]: send_ready: token=518 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet: type = 2 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet_expire_multi: token 519, name lib 
Jan 23 15:07:49 linux-glab-1 automount[20257]: umount_multi: path=/usr/local/projects/some/automount/submount/lib incl=1 
Jan 23 15:07:49 linux-glab-1 automount[20257]: umount_multi: unmounting dir=/usr/local/projects/some/automount/submount/lib 
Jan 23 15:07:49 linux-glab-1 automount[20257]: rm_unwanted: /usr/local/projects/some/automount/submount/lib 
Jan 23 15:07:49 linux-glab-1 automount[20257]: expired /usr/local/projects/some/automount/submount/lib
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_child: got pid 20257, sig 0 (0), stat 0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: sig_child: found pending op pid 20257: signalled 0 (sig 0), exit status 0
Jan 23 15:07:49 linux-glab-1 automount[19686]: send_ready: token=519 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet: type = 2 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_packet_expire_multi: token 520, name bin 
Jan 23 15:07:49 linux-glab-1 automount[20259]: umount_multi: path=/usr/local/projects/some/automount/submount/bin incl=1 
Jan 23 15:07:49 linux-glab-1 automount[20259]: umount_multi: unmounting dir=/usr/local/projects/some/automount/submount/bin 
Jan 23 15:07:49 linux-glab-1 automount[20259]: rm_unwanted: /usr/local/projects/some/automount/submount/bin 
Jan 23 15:07:49 linux-glab-1 automount[20259]: expired /usr/local/projects/some/automount/submount/bin
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_child: got pid 20259, sig 0 (0), stat 0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: sig_child: found pending op pid 20259: signalled 0 (sig 0), exit status 0
Jan 23 15:07:49 linux-glab-1 automount[19686]: send_ready: token=520 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_child: got pid 20254, sig 0 (0), stat 0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: sigchld: exp 20254 finished, switching from 2 to 5
Jan 23 15:07:49 linux-glab-1 automount[19686]: get_pkt: state 2, next 5
Jan 23 15:07:49 linux-glab-1 automount[19686]: prep_shutdown: state = 2 
Jan 23 15:07:49 linux-glab-1 automount[19686]: expire_proc: exp_proc=20261
Jan 23 15:07:49 linux-glab-1 automount[19686]: prep_shutdown: expire returns 1 
Jan 23 15:07:49 linux-glab-1 automount[19686]: handle_child: got pid 20261, sig 0 (0), stat 0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: sigchld: exp 20261 finished, switching from 5 to 6
Jan 23 15:07:49 linux-glab-1 automount[19686]: get_pkt: state 5, next 6
Jan 23 15:07:49 linux-glab-1 automount[19686]: umount_multi: path=/usr/local/projects/some/automount/submount incl=0 
Jan 23 15:07:49 linux-glab-1 automount[19686]: umount /usr/local/projects/some/automount/submount failed: retrying... 
Jan 23 15:07:50 linux-glab-1 automount[19686]: umount /usr/local/projects/some/automount/submount failed: retrying... 
Jan 23 15:07:51 linux-glab-1 automount[19686]: can't unmount /usr/local/projects/some/automount/submount 

Jan 23 15:12:09 linux-glab-1 automount[19686]: shut down, path = /usr/local/projects/some/automount/submount
Jan 23 15:12:09 linux-glab-1 automount[19686]: failed to remove dir /usr/local/projects/some/automount/submount: Device or resource busy


I'm digging through automount.c code looking for case where this would happen,
but my C skills are really weak.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
My pid is Inigo Montoya.  You kill -9 my parent process. Prepare to vi.
