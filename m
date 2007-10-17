From: "Jim Dennis" <jdennis@cadence.com>
Subject: Re: hostname lookup failed: Operation not permitted
Date: Wed, 17 Oct 2007 11:07:12 -0700
Message-ID: <920746F6DF728345915EF4D6DA610D0F03F8EFDB@MAILSJ2.global.cadence.com>
References: <mailman.1.1192536001.24077.autofs@linux.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <mailman.1.1192536001.24077.autofs@linux.kernel.org>
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

 
On Date: Tue, 16 Oct 2007 16:17:26 +0800, Ian Kent wrote:

> Subject: Re: [autofs] hostname lookup failed: Operation not permitted
> To: "jehan.procaccia" <jehan.procaccia@int-edu.eu>
> Cc: autofs mailing list <autofs@linux.kernel.org>,  "Eric. Doutreleau"
>     <eric.doutreleau@int-evry.fr>
> Message-ID: <1192522647.4443.17.camel@raven.themaw.net>

>> On Mon, 2007-10-15 at 12:06 +0200, jehan.procaccia wrote:
>> Hello,

>> I have several users that cannot automount their homdir . The logs
says:

>> Oct 14 15:56:47 anaconda automount[10054]: create_udp_client:
hostname
>> lookup failed: Operation not permitted
>> Oct 14 15:56:47 anaconda automount[10054]: create_tcp_client:
hostname
>> lookup failed: Operation not permitted

...

>> Oct 14 16:01:19 anaconda automount[10054]: create_tcp_client:
hostname

>> lookup failed: Operation not permitted

> A missing /etc/hosts file can cause this error.

> Ian

 It seems odd to get "operation not permitted" for this failure mode.
 However it seems obviously related to hostname resolution:
 (/etc/nsswitch.conf, /etc/hosts.conf, NIS or LDAP maps ... DNS ...
nscd?
 something)

--
JimD
