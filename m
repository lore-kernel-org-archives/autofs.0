From: Stef Bon <stef@bononline.nl>
Subject: Re: How to determine a path is a mountpoint.
Date: Mon, 22 Feb 2010 17:30:28 +0100
Message-ID: <201002221730.28243.stef@bononline.nl>
References: <201002152253.46863.stef@bononline.nl>
	<201002211428.39077.stef@bononline.nl>
	<4B81FFDB.8030006@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B81FFDB.8030006@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Monday 22 February 2010 04:54:03 Ian Kent wrote:


> > 
> > So, am I missing here something? Or has something changed?
> > When I look to the various init rc scripts, the file
> > /etc/sysconfig/autofs  file is sourced.
> 
> In the init script the sourcing of the configuration is redundant but
> environment variables that are exported will be seen by child processes
> (as per normal shell environment variable export rules) and can be used
> to over-ride the settings in the autofs configuration. Note that the
> internal autofs default is BROWSE_MODE="yes" and that is set to "no" by
> the default installed configuration for backward compatibility.


Now when I export them all, they are detected and used. I see logging and browse mode is set to no.

OK now I'm beginning to understand, the automounter reads the configuration values directly, from the default configuration file.
I thought the automounter reads them from the environement, cause the conf file is sourced at the beginning of the init file.

I've found the code. This is, and it happens to me more often, not well documented. Please start a wiki or something. 
I know you are very busy, I recieved some copies of emails about an important issue this weekend.

I'm working also a lot with FUSE, and the wiki there provides a lot of information, although it's not complete. 
I would like to help if I can.

Stef Bon

> 
> The USE_MISC_DEVICE is the only exception. It is used only by the init
> script for checking if /dev/autofs is present and if we want to use
> /dev/autofs for kernel communication.
> 
> Ian
