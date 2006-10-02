From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP-based auto.master and --ghost option
Date: Tue, 03 Oct 2006 01:22:49 +0800
Message-ID: <1159809769.2905.16.camel@raven.themaw.net>
References: <Pine.CYG.4.64.0609291328430.468@ninja>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.CYG.4.64.0609291328430.468@ninja>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Fri, 2006-09-29 at 14:20 -0500, Robert Giles wrote:

> Thanks for any tips out there.

Maybe a workaround would be to set DAEMONOPTIONS equal to "--ghost" in
the startup configuration file. Wherever that may be on your distro.

This would add the option to all mounts.

Ian
