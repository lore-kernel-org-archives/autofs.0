From: d i <navilein@hotmail.com>
Subject: nfs export of autofs managed mount points
Date: Mon, 21 Jan 2008 00:26:34 +0000
Message-ID: <BAY114-W13EF3D10ADD3D3F59590A5D13D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
I am trying to export through nfs a mount point which is managed by autofs.
Ideally i would like the local autofs managed mount point to automount whenever the nfs server receives a remote connection.
And then unmount (through autofs) when the nfs remote connection ended.

Is that supported by autofs/nfs  ?
How could i do it ?

Thanks!
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
