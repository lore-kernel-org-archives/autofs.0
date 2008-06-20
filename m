From: Ian Kent <raven@themaw.net>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 23:28:53 +0800
Message-ID: <1213975734.4975.17.camel@raven.themaw.net>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
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
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: autofs@linux.kernel.org, Unix Support <unix-support@ucs.cam.ac.uk>, hpa@zytor.com


On Fri, 2008-06-20 at 16:24 +0100, Anton Altaparmakov wrote:
> Which means that in /proc/*/cmdline the string that appears is "pwf- 
> amnt" (as we override argv[0] in the exec call to that effect) thus  
> the is_automount_running() function does not find the literal string  
> "automount" in there and we can run it as many times as we want (which  
> is once per user).

Why do you need to run one instance per user?
What does it get you that using a single source common global map
doesn't provide?

Ian
