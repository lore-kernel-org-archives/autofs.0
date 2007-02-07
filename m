From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Another LDAP weirdness we're seeing.
Date: Wed, 07 Feb 2007 11:27:03 -0500
Message-ID: <x49ps8mue5k.fsf@segfault.boston.devel.redhat.com>
References: <20070206225358.GJ21027@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070206225358.GJ21027@cornholio.qualcomm.com> (Mike Marion's
	message of "Tue, 6 Feb 2007 14:53:58 -0800")
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

==> On Tue, 6 Feb 2007 14:53:58 -0800, Mike Marion <mmarion@qualcomm.com> said:

Mike> Trying to track down if it's in the client at all, but related to my
Mike> last mail.. if we start the daemon with --ghost, sometimes the hosts are
Mike> failing to start all the children of /- (or even /- itself). 

Mike> The logs I've gotten when it failed were:
Mike> Feb  6 13:32:09 k8-032 automount[2243]: starting automounter version
Mike> 4.1.4, path = /-, maptype = ldap, mapname =
Mike> automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com
Mike> Feb  6 13:32:11 k8-032 automount[2243]: lookup(ldap): LDAP query failed:
Mike> No such object
Mike> Feb  6 13:32:11 k8-032 automount[2243]: failed to load map exiting

Mike> Trying to start it by running the autofs init script again by hand
Mike> shortly after this, it works fine.  Is there some point in the initial
Mike> read of the maps that has a timeout?  We're tying to narrow down if it's
Mike> the client timing out (ldap servers not responding fast enough) or if
Mike> the servers are actually returning a bad value (or the above 'no such
Mike> object') which, obviously, shouldn't be happening.

Post full debug logs and maps.

-Jeff
