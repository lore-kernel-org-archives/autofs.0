From: Michael Marion <mmarion@qualcomm.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Thu, 4 Aug 2005 15:44:13 -0700 (PDT)
Message-ID: <200508042244.j74MiD8F000918@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
To: autofs@linux.kernel.org

On  3 Aug, Jeff Moyer wrote:

> Then trigger the bug and send the logs.  I think the logs you sent were
> incomplete.

Didn't seem to add much more... same output with attempt to mount /net/tau
(which should do tau:/local/mnt on /net/tau/local/mnt but puts it on /net/tau
directly instead):

Aug  4 15:42:16 rs-workstation automount[20058]: mount(nfs): host /local/mnt:
lookup failure
Aug  4 15:42:16 rs-workstation automount[20058]: >> nfs server reported tcp
not available, falling back to udp
Aug  4 15:42:16 rs-workstation automount[20058]: >> Using NFS over UDP can
cause data corruption.
Aug  4 15:42:16 rs-workstation automount[20058]: >> Please refer to the
WARNINGS section of the nfs(5) manual page.

Building kernel with Ian's suggested patch now...

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"There are no significant bugs in our released software that any
significant number of users want fixed." - Bill Gates in an interview with
Focus magazine, Oct 23, 1995.
