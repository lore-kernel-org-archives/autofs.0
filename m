From: Ian Kent <raven@themaw.net>
Subject: Re: Automount log errors
Date: Wed, 19 Nov 2003 09:01:32 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311190851570.17313-100000@wombat.indigo.net.au>
References: <1069200829.28347.3.camel@ugly>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1069200829.28347.3.camel@ugly>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Cc: autofs@linux.kernel.org

On Tue, 18 Nov 2003, Taylor, ForrestX wrote:

> I get these errors in logwatch from autofs:
>
> Use of uninitialized value in hash element at
> /etc/log.d/scripts/services/automount line 28, <STDIN> line 2.
> Use of uninitialized value in hash element at
> /etc/log.d/scripts/services/automount line 28, <STDIN> line 2.
>
>
> The offending lines are:
>
> while (defined($ThisLine = <STDIN>)) {
> ...
>    elsif ($ThisLine =~ /^mount\(nfs\): nfs: mount failure .*:.* on .*$/)
> {
>       $Failed{$Mount}{'nfsm'}++;
>
> This is on Fedora Core 1, using autofs-4.1.0-beta3.  Any ideas?
>

Looks like this script has found something in the log.

Can you find anything in your logs.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
