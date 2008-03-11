From: Ian Kent <raven@themaw.net>
Subject: Re: Can't mount shares ending in $
Date: Tue, 11 Mar 2008 10:16:53 +0900
Message-ID: <1205198214.2955.7.camel@raven.themaw.net>
References: <47D5CD16.5000807@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D5CD16.5000807@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org


On Tue, 2008-03-11 at 11:06 +1100, Matthew Jurgens wrote:
>  From the debug info, the mount command that fails is:
> mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /smb/matthew/C$

Does this command work if you run it manually?

Ian
