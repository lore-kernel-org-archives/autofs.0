From: "Dege, Robert C." <robert.dege@ngc.com>
Subject: softlink creation on startup
Date: Thu, 20 Jan 2005 16:15:31 -0600
Message-ID: <B845DD7107659345A6436D4BCF0BDF130AB97BA8@xcgil006.northgrum.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org


Hi,

I'm trying to integrate a linux box into a TRU64 UNIX network, and am seeking some insight with
automounting.  Our TRU64 network uses NIS to propagate data among our client systems.  The
systems have been configured to use the NIS auto.master map to establish automount links.  
Here's a snippet of the file:

# Razor Links
/newrazor       -rw,intr        newrazor:/razor
/arazor         -rw,intr        cerberus:/razor

# Misc. Alpha Links
/home           -rw,intr        mercury:/home
/vxdisk         -rw,intr        as2508:/vxdisk


I am already aware that the auto.master file format is incompatible with autofs.  I am working
with automount2amd to generate a local auto.master file for the linux box.  The feature that
I'm looking for is the soft link generation upon autofs startup.  In TRU64, when automount is
started, softlinks are created in root, based on the NIS auto.master map.  So, an ls -l in
a TRU64 client would display this:

...
lrwxrwxrwx   1 root     system        20 Jan 17 16:46 arazor -> /.automount/arazor
lrwxrwxrwx   1 root     system        20 Jan 20 17:05 home -> /.automount/home
lrwxrwxrwx   1 root     system        20 Jan 20 07:51 newrazor -> /.automount/newrazor
lrwxrwxrwx   1 root     system        20 Jan 17 16:46 vxdisk -> /.automount/vxdisk
...

My question is this:  Is it possible to configure auto.master so that when autofs starts up,
These soft links will be automatically created.  When autofs is shutdown, the softlinks are
automatically removed.

-Rob

PS - If I didn't convey my question coherently, please let me know so that I can elaborate.
