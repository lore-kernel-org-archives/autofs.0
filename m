From: "Saxena, Sarvesh (IDS DM&DS)" <sarvesh_saxena@ml.com>
Subject: Configure automounter to use files first and then nis
Date: Fri, 5 Mar 2004 11:02:06 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <85A0568A9DA8D5119E1C00B0D049FEBF07E76E17@ehope11.hew.us.ml.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>


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
