From: <Scott_Rochford@DELL.com>
Subject: automounted filesystems being unmounted and mounted every
	minute
Date: Fri, 27 Oct 2006 16:14:28 +0100
Message-ID: <0F5A1C742BC73849AFF518F1F8249D4D0181D362@mtpx3m2.mtp.emea.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

Hi,

> > Take a look at http://people.redhat.com/jmoyer for documentation on
how to
> > gather debug information from the automounter.  Basically, you need
to log
> > daemon.* somewhere.
> gnome-panel?
> Oct 16 14:54:51 jenny automount[24104]: handle_packet: type = 3
> Oct 16 14:54:51 jenny automount[24104]:
handle_packet_missing_indirect: token 
> 19801, name share, request pid 14360

I've been puzzling over a similar problem with mounts of long since
removed users' home directories occurring every few minutes for some
time and was thrilled to discover this thread on the subject, however
after enabling debugging as instructed I only get:

Oct 27 16:06:04 e1shdb03 automount[16563]: handle_packet: type = 0
Oct 27 16:06:04 e1shdb03 automount[16563]: handle_packet_missing: token
1487772, name scott
Oct 27 16:06:04 e1shdb03 automount[16563]: attempting to mount entry
/users/scott

RHEL AS 3
autofs-4.1.3-154
2.4.21-37.0.1.ELhugemem

Do you have any other suggestions for methods to identify the processes
that are triggering these mount attempts?

Thanks in advance,
--
Scott Rochford
