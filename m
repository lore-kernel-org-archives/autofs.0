From: Nico De Ranter <nico.deranter@sonycom.com>
Subject: Re: automounting replicated servers using NFSv4 fails
Date: Mon, 21 Feb 2011 10:26:52 +0100
Message-ID: <1298280412.2072.0.camel@puppy.sonytel.be>
References: <1298034589.18517.52.camel@puppy.sonytel.be>
	<1298087286.2851.29.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1298087286.2851.29.camel@perseus>
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

On Sat, 2011-02-19 at 11:48 +0800, Ian Kent wrote:
> On Fri, 2011-02-18 at 14:09 +0100, Nico De Ranter wrote:
> > Hi,
> > 
> > I have a number of Linux clients (Ubuntu 10.04) that mount a (read-only)
> > directory from 3 replicated servers using NFSv3.  I am now in the
> > process of moving to NFSv4.  I can mount the directories using NFSv4
> > manually. I can mount the directories using autofs over NFSv4 when I
> > specify only 1 server (any of the 3 will work), but when I add all 3
> > servers to the automount configuration file the mount fails.
> 
> Works OK for me, on Fedora 12.

Which version of autofs are you using?

Nico

-- 
With kind regards

Nico De Ranter
Senior System Administrator
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village - Da Vincilaan 7-D1 - B-1935 Zaventem - Belgium

Phone:    +32 (0)2 700 8641
Fax:          +32 (0)2 700 8622
E-mail:    nico.deranter@eu.sony.com

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 - RPR Brussels
Fortis - BIC GEBABEBB - IBAN BE41293037680010
