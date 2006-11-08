From: Joe Pruett <joey@clean.q7.com>
Subject: Re: autofs illustrations
Date: Wed, 8 Nov 2006 14:34:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611081431170.25763@q7.q7.com>
References: <200611071719.kA7HJSvl002639@cs.utexas.edu>
	<1162958395.3555.8.camel@localhost>
	<4551DAE2.1080704@redhat.com> <1162994432.3555.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162994432.3555.15.camel@localhost>
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

> > Actually, there is work on going to reduce the number of connections 
> > from the
> > client to the server from one per mount to one per client server 
> > combination.
> > Solaris has always done this and it works out quite well in practice.
> 
> Excellent.
> Tell me more?

this sure sounds like the old solaris automount setup of:

foo	server:/path/disk:foo
bar	server:/path/disk:bar

hitting foo would mount server:/path/disk and then symlink/bind for foo.  
hitting bar within the timeout period would just cause another 
symlink/bind instead of another mount.

i am mimicking this on my setup with two maps.  one for disks and then one 
for home dirs that points to the disks mount.  it still hiccups 
occasionally since the two automounts don't really know about each other.  
having this functionality back in automount would be great.
