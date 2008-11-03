From: Stef Bon <stef@bononline.nl>
Subject: Re: Proposed update to auto.smb
Date: Mon, 3 Nov 2008 15:48:56 +0100
Message-ID: <200811031548.56591.stef@bononline.nl>
References: <1225679565.2911.31.camel@zeus.themaw.net>
	<1225681504.2911.41.camel@zeus.themaw.net>
	<x49vdv4ki7y.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7565060713117480073=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49vdv4ki7y.fsf@segfault.boston.devel.redhat.com>
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
Cc: Ian Kent <raven@themaw.net>

--===============7565060713117480073==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_Y9wDJC4ipdhrL2R"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_Y9wDJC4ipdhrL2R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 03 November 2008 15:16:33 Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> > On Mon, 2008-11-03 at 11:32 +0900, Ian Kent wrote:
> >> Hi all,
> >>
> >> Stef Bon has reported some difficulty with the current auto.smb.
> > -opts="-fstype=cifs"
> > +
> > +FILESYSTEM="cifs"
> > +
>
> So, umm, when is $FILESYSTEM not going to be cifs?
>
That's a good one. I thought it's a good thing to still support
smbfs, which is not cifs obviously.

> > +if [ "$FILESYSTEM" != "cifs" ]; then
> > +	opts="-fstype=$FILESYSTEM,guest"
> > +else
> > +	for P in /bin /sbin /usr/bin /usr/sbin
> > +	do
> > +		if [ -x $P/nmblookup ]; then
> > +			NMBLOOKUP=$P/nmblookup
> > +			break
> > +		fi
> > +	done
> > +
> > +	if [ ! -x "$NMBLOOKUP" ]; then
> > +		exit 1
> > +	fi
>
> Is it possible to not have the nmblookup program?  It seems to me it
> would be safer to at least try the mount w/o the ip address if you can't
> obtain one.

Yes, that's also good choice. Now the script fails when nmblookup is not 
found, which is not always necessary.

>
> > +
> > +	ipaddress=$($NMBLOOKUP $key --debug-level=0 2>>/dev/null | grep '<00>'
> > | awk '{ print $1 }') +	if [ -z "$ipaddress" ]; then
> > +		exit 1
> > +	fi
> > +
> > +	opts="-fstype=cifs,guest,ip=$ipaddress"
> > +fi
> >
> >  for P in /bin /sbin /usr/bin /usr/sbin
> >  do
>
> Can we compress these two loops that do the same thing (determine the
> path to the samba/cifs binaries)?

Yes possibly. But the loop to find nmblookup is only done when using cifs (see 
above..). Also, when combined, the loop should not stop when only one is 
found, but both. But yes it's possible to create one loop with some if and 
thens. 

Stef


--Boundary-00=_Y9wDJC4ipdhrL2R
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:10pt; font-weight:400; font-style:normal;">On Monday 03 November 2008 15:16:33 Jeff Moyer wrote:<br>
&gt; Ian Kent &lt;raven@themaw.net&gt; writes:<br>
&gt; &gt; On Mon, 2008-11-03 at 11:32 +0900, Ian Kent wrote:<br>
&gt; &gt;&gt; Hi all,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Stef Bon has reported some difficulty with the current auto.smb.<br>
&gt; &gt; -opts="-fstype=cifs"<br>
&gt; &gt; +<br>
&gt; &gt; +FILESYSTEM="cifs"<br>
&gt; &gt; +<br>
&gt;<br>
&gt; So, umm, when is $FILESYSTEM not going to be cifs?<br>
&gt;<br>
That's a good one. I thought it's a good thing to still support<br>
smbfs, which is not cifs obviously.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>&gt; &gt; +if [ "$FILESYSTEM" != "cifs" ]; then<br>
&gt; &gt; +	opts="-fstype=$FILESYSTEM,guest"<br>
&gt; &gt; +else<br>
&gt; &gt; +	for P in /bin /sbin /usr/bin /usr/sbin<br>
&gt; &gt; +	do<br>
&gt; &gt; +		if [ -x $P/nmblookup ]; then<br>
&gt; &gt; +			NMBLOOKUP=$P/nmblookup<br>
&gt; &gt; +			break<br>
&gt; &gt; +		fi<br>
&gt; &gt; +	done<br>
&gt; &gt; +<br>
&gt; &gt; +	if [ ! -x "$NMBLOOKUP" ]; then<br>
&gt; &gt; +		exit 1<br>
&gt; &gt; +	fi<br>
&gt;<br>
&gt; Is it possible to not have the nmblookup program?  It seems to me it<br>
&gt; would be safer to at least try the mount w/o the ip address if you can't<br>
&gt; obtain one.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Yes, that's also good choice. Now the script fails when nmblookup is not found, which is not always necessary.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +	ipaddress=$($NMBLOOKUP $key --debug-level=0 2&gt;&gt;/dev/null | grep '&lt;00&gt;'<br>
&gt; &gt; | awk '{ print $1 }') +	if [ -z "$ipaddress" ]; then<br>
&gt; &gt; +		exit 1<br>
&gt; &gt; +	fi<br>
&gt; &gt; +<br>
&gt; &gt; +	opts="-fstype=cifs,guest,ip=$ipaddress"<br>
&gt; &gt; +fi<br>
&gt; &gt;<br>
&gt; &gt;  for P in /bin /sbin /usr/bin /usr/sbin<br>
&gt; &gt;  do<br>
&gt;<br>
&gt; Can we compress these two loops that do the same thing (determine the<br>
&gt; path to the samba/cifs binaries)?<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Yes possibly. But the loop to find nmblookup is only done when using cifs (see above..). Also, when combined, the loop should not stop when only one is found, but both. But yes it's possible to create one loop with some if and thens. <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Stef<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-00=_Y9wDJC4ipdhrL2R--


--===============7565060713117480073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7565060713117480073==--

