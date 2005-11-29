From: Ian Kent <raven@themaw.net>
Subject: Re: Latest docs
Date: Tue, 29 Nov 2005 18:54:10 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511291849220.2069@donald.themaw.net>
References: <20051128203952.mgakgc8wajok4k0k@www.mommabears.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051128203952.mgakgc8wajok4k0k@www.mommabears.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike@mommabears.com
Cc: autofs@linux.kernel.org

On Mon, 28 Nov 2005, mike@mommabears.com wrote:

> Folks,
> 
> Just looking for the latest docs which explain the autofs scripts
> (/etc/auto.net, /etc/auto.smb) in use on SUSE and Fedora. The HOWTOs don't seem
> up to date, and the latest stuff from http://people.redhat.com/~jmoyer/ don't
> seem to address these scripts. Yes, I can use these scripts to find the shares
> with commands such as:

These are examples of using a program map.

> 
> /etc/auto.smb hostname(or IP address)

and there's not much else to it.

The key to these scripts are the host name and the keys is passed to the 
scripts from autofs at mount time.

> 
> But I don't know how to make this into mountable directories in /smb and /net as
> directed via /etc/auto.master.

I thought there was usually a line like (perhaps commented out):

/net	/etc/auto.net

in most distributed packages?

Ian
