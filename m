From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: Configure automounter to use files first and then nis
Date: Mon, 8 Mar 2004 10:07:40 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE718D44C5@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Saxena, Sarvesh (IDS DM&DS)" <sarvesh_saxena@ml.com>, autofs@linux.kernel.org

Hi Sarvesh,

I've only observed the behavior you are looking for when adding the
"+" entries to /etc/auto.master.

On my machines, my auto.master usually looks like:
/net	program:/etc/auto.net
+auto_master

This works fine for me, however it doesn't work when the "+" is added
to any of the file/program maps (ie adding +auto_home to your 
/etc/auto_home won't cause the automounter to look to NIS for
keys).

-Steve

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org]On Behalf Of Saxena, Sarvesh
(IDS DM&DS)
Sent: Friday, March 05, 2004 10:02 AM
To: 'autofs@linux.kernel.org'
Subject: [autofs] Configure automounter to use files first and then nis



Hi,

  "files nis"  in the nsswitch.conf is not working.
  Also putting /etc/auto_home in auto.master
  and then putiing +auto_home in /etc/auto_home is not working.
  I want to use files first and if entry not found to go to yp.
  Any help will be appreciated. Thanks.


Sarvesh

==============================================================================

If you are not an intended recipient of this e-mail, please notify
the sender, delete it and do not read, act upon, print, disclose,
copy, retain or redistribute it.

Click here for important additional terms relating to this e-mail.
     <http://www.ml.com/email_terms/>

==============================================================================

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
