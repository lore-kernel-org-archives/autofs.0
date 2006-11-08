From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs illustrations
Date: Wed, 08 Nov 2006 18:03:47 -0500
Message-ID: <x49mz71pmlo.fsf@segfault.boston.devel.redhat.com>
References: <200611071719.kA7HJSvl002639@cs.utexas.edu>
	<1162958395.3555.8.camel@localhost> <4551DAE2.1080704@redhat.com>
	<1162994432.3555.15.camel@localhost>
	<Pine.LNX.4.64.0611081431170.25763@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611081431170.25763@q7.q7.com> (Joe Pruett's
	message of "Wed, 8 Nov 2006 14:34:27 -0800 (PST)")
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

==> On Wed, 8 Nov 2006 14:34:27 -0800 (PST), Joe Pruett <joey@clean.q7.com> said:

Joe> > > Actually, there is work on going to reduce the number of
Joe> connections > > from the > > client to the server from one per
Joe> mount to one per client server > > combination.  > > Solaris has
Joe> always done this and it works out quite well in practice.
Joe> > 
Joe> > Excellent.  > Tell me more?

Joe> this sure sounds like the old solaris automount setup of:

Joe> foo server:/path/disk:foo bar server:/path/disk:bar

Joe> hitting foo would mount server:/path/disk and then symlink/bind
Joe> for foo.  hitting bar within the timeout period would just cause
Joe> another symlink/bind instead of another mount.

Quite different.  I think Pete is referring to connection sharing.

-Jeff
