From: Stef Bon <stef@bononline.nl>
Subject: Please some comment on this construction.
Date: Sat, 4 Aug 2007 13:52:43 +0200
Message-ID: <200708041352.43567.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hello,

since some time now I'm using a construction which makes use of a construction of auto files
(auto.master, auto.hosts and auto.share) to mount smb shares on demand.
I'm wrriting a howto about it now, which will appear soon on HowtoForge.

Now I've found information about the configuartion of the three files on:

http://www.novell.com/coolsolutions/tip/19076.html

A short summary:

there are three files, the auto.master file:

/mydomain	/etc/auto.mydomain

the auto.mydomain file:

* -fstype=autofs,-Dhost=& file=:/etc/auto.mydomain.sub

and the /etc/auto.mydomain.sub

* ${host}:/&
* -fstype=smbfs,workgroup=mydomain,uid=myuser,credentials=/home/myuser/.smb/mydomain ://${host}/&

Now my question is about the latest file. First thing: what is happening here? The first line, what does it?

I anybody can help me here,

thanks,

Stef Bon
the Netherlands
