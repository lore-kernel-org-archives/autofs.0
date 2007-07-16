From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 + ldap + ldap replication
Date: Mon, 16 Jul 2007 23:17:48 +0800
Message-ID: <1184599068.3344.5.camel@raven.themaw.net>
References: <469985DF.9010607@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <469985DF.9010607@wesmo.com>
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
To: Rich West <Rich.West@wesmo.com>
Cc: autofs@linux.kernel.org

On Sat, 2007-07-14 at 22:26 -0400, Rich West wrote:
> We have an LDAP infrastructure where all of the automount maps 
> (auto.master and auto.home) are pulled out of LDAP.  In this instance, 
> we have two LDAP servers, one primary, and the other is a replica.  The 
> clients are all Fedora/Redhat systems.  Most of them are running 
> autofs4, and a few newer ones are running autofs5.

Version information for autofs would be good.
I looks like we're not getting all the debug info in the log, are you
sending all priorities of facility daemon to the log?

Ian
