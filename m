From: csarid <csarid@yahoo.com>
Subject: Re: Cannot see automount point subdirecties
Date: Wed, 16 Aug 2006 10:19:00 -0700 (PDT)
Message-ID: <20060816171900.17130.qmail@web56410.mail.re3.yahoo.com>
References: <44E2DB61.8050101@ant.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8155177370022879651=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44E2DB61.8050101@ant.uni-bremen.de>
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
To: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Cc: autofs@linux.kernel.org

--===============8155177370022879651==
Content-Type: multipart/alternative; boundary="0-938554731-1155748740=:15154"
Content-Transfer-Encoding: 8bit

--0-938554731-1155748740=:15154
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I just check the processes and it's definitely not running with a -g or --ghost. I believe it was built with both autofs v3 and 4, but how can I check for sure?
   
  Thanks!
Heinrich Rebehn <rebehn@ant.uni-bremen.de> wrote:
  csarid wrote:
> Hello,
> 
> I am running linux kernal version 2.4 automounting files using nis. The issue is that after I, for instanced "cd /programs" and then do an "ls -la" no subdirectories showup unless I explicitly change directory to a subdirectory. Otherwise, no files or directories are listed. 
> 
Is the automount process running with "-g" or "--ghost" ?
Also, i have seen that if you compile the kernel with both autofs v3 
*and* v4, ghosting will not work.

--
Heinrich Rebehn

University of Bremen
Physics / Electrical and Electronics Engineering
- Department of Telecommunications -

Phone : +49/421/218-4664
Fax : -3341


 		
---------------------------------
Get your email and more, right on the  new Yahoo.com 
--0-938554731-1155748740=:15154
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I just check the processes and it's definitely not running with a -g or --ghost. I believe it was built with both autofs v3 and 4, but how can I check for sure?</div>  <div>&nbsp;</div>  <div>Thanks!<BR><B><I>Heinrich Rebehn &lt;rebehn@ant.uni-bremen.de&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">csarid wrote:<BR>&gt; Hello,<BR>&gt; <BR>&gt; I am running linux kernal version 2.4 automounting files using nis. The issue is that after I, for instanced "cd /programs" and then do an "ls -la" no subdirectories showup unless I explicitly change directory to a subdirectory. Otherwise, no files or directories are listed. <BR>&gt; <BR>Is the automount process running with "-g" or "--ghost" ?<BR>Also, i have seen that if you compile the kernel with both autofs v3 <BR>*and* v4, ghosting will not work.<BR><BR>--<B
 R>Heinrich Rebehn<BR><BR>University of Bremen<BR>Physics / Electrical and Electronics
 Engineering<BR>- Department of Telecommunications -<BR><BR>Phone : +49/421/218-4664<BR>Fax : -3341<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Get your email and more, right on the <a href="http://us.rd.yahoo.com/evt=42973/*http://www.yahoo.com/preview"> new Yahoo.com</a> 

--0-938554731-1155748740=:15154--


--===============8155177370022879651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8155177370022879651==--

