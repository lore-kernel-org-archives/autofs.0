From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Re: Bug in autofs v4.1.4 init.d script for reload (and fix)
Date: Wed, 13 Sep 2006 10:42:41 +0100
Message-ID: <4507D291.1DA20B3E@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <44EB1231.7ABAA89B@ggr.co.uk>
	<45015498.22A9C700@ggr.co.uk> <4506AEDE.6B8D5E65@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Gordon Lack wrote:
> 
>    The init.d script when asked to reload compares the list of required
> mount commands (in TMP1) against the list of currently-running automount
> processes (in TMP2).
>... 
>    ie: replace:
> 
>         ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
>             while read pid tt stat time command; do
>...
>         ps -e -opid=,ppid=,command= | grep " [1] $DAEMON " | (
>             while read pid ppid command; do


   Make that ps -we -opid=............

   The -w is needed for older versions of procps (eg: 2.0.7)
