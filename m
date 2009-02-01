From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: Segfaults in lookup_hosts.c, probably caused by
Date: Sun, 01 Feb 2009 22:16:46 +0100
Message-ID: <4986113E.500@inria.fr>
References: <4984CB32.8080709@inria.fr>
	<1233458418.2967.44.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1233458418.2967.44.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent a =E9crit :
> On Sat, 2009-01-31 at 23:05 +0100, Guillaume Rousse wrote:
>> Hello list.
>>
>> I just released a 5.0.4 package with all current patches applied, and I =

>> had this report:
>> https://qa.mandriva.com/show_bug.cgi?id=3D47423
>>
>> I can reproduce the issue with this simple master map:
>> [root@oberkampf guillaume]# cat /etc/autofs/auto.master
>> /net	-hosts
> =

> Thanks to the backtrace you provided I see this looks exactly like one
> of the issues that was identified by the code analysis that Paul
> Wankadia was kind enough to do for us. Thanks Paul.
> =

> I've pulled out that particular hunk of the patch that resulted from
> that effort so if you could have your customer test it I'll commit it
> straight away if it resolves the problem.
I tested it myself, it fixes the issue, thanks. I'll ask original =

reporter to test is also for completness.
-- =

BOFH excuse #399:

We are a 100% Microsoft Shop.
