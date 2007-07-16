From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs5 + ldap + ldap replication
Date: Mon, 16 Jul 2007 14:59:20 -0400
Message-ID: <x497ip0w4xj.fsf@segfault.boston.devel.redhat.com>
References: <469985DF.9010607@wesmo.com>
	<1184599068.3344.5.camel@raven.themaw.net>
	<469BB868.4080603@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <469BB868.4080603@wesmo.com> (Rich West's message of "Mon\,
	16 Jul 2007 14\:26\:48 -0400")
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Mon, 16 Jul 2007 14:26:48 -0400, Rich West <Rich.West@wesmo.com> said:

Rich> Ian Kent wrote:
>> On Sat, 2007-07-14 at 22:26 -0400, Rich West wrote:
>> 
>>> We have an LDAP infrastructure where all of the automount maps 
>>> (auto.master and auto.home) are pulled out of LDAP.  In this instance, 
>>> we have two LDAP servers, one primary, and the other is a replica.  The 
>>> clients are all Fedora/Redhat systems.  Most of them are running 
>>> autofs4, and a few newer ones are running autofs5.
>>> 
>> 
>> Version information for autofs would be good.
>> I looks like we're not getting all the debug info in the log, are you
>> sending all priorities of facility daemon to the log?
>> 

Rich> The Fedora Core 5 clients are using autofs 4.1.4, and the Fedora Core 6
Rich> clients are using 5.0.1 (RC3).

Rich> As far as logging goes, what is the log facility used for autofs?  I've
Rich> got syslog splitting apart some of the messages to separate files
Rich> (local2 is designated for named for us, with local4 designated to LDAP,
Rich> &etc).

Autofs uses the daemon facility.

-Jeff
