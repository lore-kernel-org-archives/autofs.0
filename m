From: Ian Kent <raven@themaw.net>
Subject: Re: latest autofs from centos 4
Date: Thu, 18 Sep 2008 00:17:44 +0800
Message-ID: <1221668264.3001.25.camel@raven.themaw.net>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-09-17 at 09:02 -0700, Joe Pruett wrote:
> i was to onervous to try the real patch for now.  so i just quickly hacked 
> in another buffer using the MAX_IFC_LEN.  so far it seems to be happy.  i 
> guess i'll find out about the new malloc setup when i go to 5.3.
> 

But that shouldn't work because the ifc struct is 40 chars so
MAX_IFC_BUF will allow 51 such buffers, not nearly close enough to 1000.

Also the patch starts with an alloc of MAX_IFC_BUF and add MAX_IFC_BUF
each time it find it not large enough.

The static buffer length variable is the way to go I think.

> diff -ru autofs-5.0.1/modules/replicated.c autofs-new/modules/replicated.c
> --- autofs-5.0.1/modules/replicated.c   2008-09-16 12:08:03.000000000 -0700
> +++ autofs-new/modules/replicated.c     2008-09-17 08:01:58.000000000 -0700
> @@ -99,7 +99,7 @@
>   {
>          struct sockaddr_in *msk_addr, *if_addr;
>          struct in_addr *hst_addr;
> -       char tmp[20], buf[MAX_ERR_BUF], *ptr;
> +       char tmp[20], buf[MAX_ERR_BUF], ibuf[MAX_IFC_BUF], *ptr;
>          struct ifconf ifc;
>          struct ifreq *ifr, nmptr;
>          int sock, cl_flags, ret, i;
> @@ -122,8 +122,8 @@
>                  fcntl(sock, F_SETFD, cl_flags);
>          }
> 
> -       ifc.ifc_len = sizeof(buf);
> -       ifc.ifc_req = (struct ifreq *) buf;
> +       ifc.ifc_len = sizeof(ibuf);
> +       ifc.ifc_req = (struct ifreq *) ibuf;
>          ret = ioctl(sock, SIOCGIFCONF, &ifc);
>          if (ret == -1) {
>                  char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> @@ -138,7 +138,7 @@
>          i = 0;
>          ptr = (char *) &ifc.ifc_buf[0];
> 
> -       while (ptr < buf + ifc.ifc_len) {
> +       while (ptr < ibuf + ifc.ifc_len) {
>                  ifr = (struct ifreq *) ptr;
> 
>                  switch (ifr->ifr_addr.sa_family) {
> @@ -162,7 +162,7 @@
>          i = 0;
>          ptr = (char *) &ifc.ifc_buf[0];
> 
> -       while (ptr < buf + ifc.ifc_len) {
> +       while (ptr < ibuf + ifc.ifc_len) {
>                  ifr = (struct ifreq *) ptr;
> 
>                  switch (ifr->ifr_addr.sa_family) {
