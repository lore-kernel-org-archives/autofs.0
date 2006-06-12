From: "aptosca" <aptosca@esseff.org>
Subject: RE: getting parameters to executable maps
Date: Mon, 12 Jun 2006 12:57:28 -0700
Message-ID: <000101c68e5a$6f30d570$4d928050$@org>
References: <1149849684.23627.19.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1149849684.23627.19.camel@raven.themaw.net>
Content-Language: en-us
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
Content-Type: text/plain; charset="us-ascii"
To: 'Ian Kent' <raven@themaw.net>, aptosca <aptosca@esseff.org>
Cc: autofs@linux.kernel.org

I have a network service that defines a filesystem namespace. I'd like to
write an executable map that uses that service to return map entries to
automount. Abstractly, the executable map takes the namespace path, queries
the web service, and returns a map entry to automount. The map entry is
either a pointer to a real filesystem or an -fstype=autofs entry that causes
the executable map to be executed again when/if an entry in the directory is
touched.

The only hole in this is that the program being executed needs the entire
namespace path (or something with the same information) in order to do the
lookup. The autofs API only gives the map the key, making the context
implicit in the map itself.

Here's an example, if executable maps could take arguments:

Auto.master would have something like

	/net /etc/autofs/nsmap

Then doing a cd /net/a, nsmap would get called with argument a.

Nsmap, not seeing only one argument, would return something like

	-fstype=autofs program:/etc/autofs/nsmap /a

Which would get an automount started on /net/a. Then, doing a 

	Cd /net/a/b

Nsmap would get called with /etc/autofs/nsmap /a b, for which it could
return

	-fstype=autofs program:/etc/autofs/nsmap /a/b

Etc.

Arguably, this isn't the best way to do this since. An alternative would be
to pass some of the options to the executable maps, so you could do
something like

	-fstype=autofs,-ns=/a/b program:/etc/autofs/nsmap

Is this any clearer? Any worse or better an idea?

I could possibly do the same thing if I could wrap the web service in an
LDAP or NIS service. That would have the advantage of not requiring code on
the client. Or, I could add XMLRPC as a map type to automount ... Neither
LDAP nor NIS seem easy to wrap ...
